# == Schema Information
#
# Table name: sponsors
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  site       :string(255)
#  state_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Sponsor < ActiveRecord::Base
  has_attached_file :image, :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :s3_host_name=> "s3-us-west-2.amazonaws.com",
      :styles => {
        :thumb => "80x80#" },
      :convert_options => {
        :thumb => "-quality 75 -strip" }
  belongs_to :state
  
  has_many :profit_sponsor
  has_many :non_profits, :through => :profit_sponsor
  
  validates_attachment_size :image, :less_than => 2000.kilobytes, :message => "Image max size is 2000KB"
  accepts_nested_attributes_for :profit_sponsor, :allow_destroy => true
  

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

end
