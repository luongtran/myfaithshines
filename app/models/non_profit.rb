# == Schema Information
#
# Table name: non_profits
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  site       :string(255)
#  zipcode    :string(12)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  state_id   :integer(4)
#

class NonProfit < ActiveRecord::Base
  has_attached_file :snapshot, :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :s3_host_name=> "s3-us-west-2.amazonaws.com",
      :styles => {
      :thumb => "80x80#" },
    :convert_options => {
      :thumb => "-quality 75 -strip" }
      
   has_attached_file :logo, :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml", 
      :s3_host_name=> "s3-us-west-2.amazonaws.com",
      :styles => {
      :thumb => "80x80#" },
    :convert_options => {
      :thumb => "-quality 75 -strip" } 
      
  attr_accessible :address, :zipcode, :lat, :lng, :state_id, :name, :email, :site, :non_profit_type_id
      
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  belongs_to :state
  has_many :rooms
  has_many :reservations
  has_many :rooms
  has_many :profit_sponsor
  has_many :sponsors, :through => :profit_sponsor
  belongs_to :non_profit_type
   
  validates_attachment_size :logo, :less_than => 2000.kilobytes, :message => "Image max size is 2000KB"
  
  before_create :initialize_update_flag
  before_destroy :check_for_rooms
  
  before_save :address_to_lat_lng

  def check_for_rooms  
    unless rooms.nil?     
      self.errors[:base] << "This Non Profit belongs to a Room."
      return false   
    end 
  end 
  
  def self.search_near_by_zipcode(zipcode, radius)
    #NonProfit.geo_scope(:origin=>zipcode, :conditions=>"distance<#{radius}")
    NonProfit.geo_scope(:within => radius, :origin => zipcode)
  end
  
  include RestClient

  # Get a URL
  #def makeSnapshotRequest(url)
  #  RestClient.get(url)
  #end
  
  
  def site_sanitized
    if site.nil?
      return nil
    else
      if site.starts_with?('http://') || site.starts_with?('https://')
        return site
      else
        return 'http://' +  site
      end
    end
      
  end
    
  private
  def initialize_update_flag
    self.update_flag = true
  end
  
  def save_snapshot
     
    url = Settings.base_path  + '/assets/blocks.css'
    css = StringIO.new( RestClient.get(url) )
    cssstring = css.string
    
    html_to_show = render_to_string :partial => 'blocks/blocks.html.erb' , :locals=>{:rooms=> self.rooms, :non_profit => self}
    html_to_show = "<html><head><style>" + cssstring + "</style></head><body>" + html_to_show.gsub('<span class="img_placeholder"></span>', '<img src="' +  request.protocol()+request.host_with_port + '/assets/paw.png">').gsub('src="/assets/reserve.png"','src="' +  request.protocol()+request.host_with_port + '/assets/reserve.png"' ) + "</body></html>"
    kit = IMGKit.new(html_to_show, quality: 40, zoom: 0.2)
    img = kit.to_img(:png)
    
    file = Tempfile.new(["template_#{self.id.to_s}", 'png'], 'tmp', :encoding => 'ascii-8bit')
    file.write(img)
    file.flush
    self.snapshot = file
    self.save
    
    file.unlink 
  end
  
  private
  def address_to_lat_lng
    geo = Geokit::Geocoders::MultiGeocoder.geocode self.address
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat, geo.lng if geo.success
  end
  
  
end
