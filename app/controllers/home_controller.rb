require 'rest_client'
require 'stringio'

class HomeController < ApplicationController 
  before_filter :authenticate_user!, :only => [:search_churches_near_user]
  
  
  def index
    @rooms = Room.all
    @nonprofits = NonProfit.find(:all, :order => "name")
    @sponsors = Sponsor.where(:featured => true)
  end
  
  def get_started
    @nonprofits = NonProfit.all
    if current_user.blank?
      @user_room = ''
    else
       @user_room = Room.where(:user_id => current_user.id)
    end   
  
  end
  
  def getstarted_form
    dog_id = params[:dog_id]
    nonprofits = NonProfit.all
    render :json => {
        :status    => "success",
        :html => render_to_string(:partial => "home/getstarted", :locals => {:dog_id => dog_id, :nonprofits => nonprofits}),
        :id => params[:id]
    }
    
  end
  
  
  def search_churches_near_user
    
    @non_profits = NonProfit.search_near_by_zipcode(current_user.zipcode, current_user.location_radius)
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def legal_mumbo
    
  end
  
  def get_us
    
  end
  
  def spread_the_word
    
  end
  
  def all_sponsors
    @boonie_dogs = Sponsor.where(:category => 'Boonie Dog').order(:name)
    @lucky_dogs = Sponsor.where(:category => 'Lucky Dog').order(:name)
    @working_dogs = Sponsor.where(:category => 'Working Dog').order(:name)
    @hot_dogs = Sponsor.where(:category => 'Hot Dog').order(:name)
    @big_dogs = Sponsor.where(:category => 'Big Dog').order(:name)
    @top_dogs = Sponsor.where(:category => 'Top Dog').order(:name)
    @the_dogs = Sponsor.where(:category => '"THE" Dog').order(:name)
  
  end
  
  def overview
    
  end
  
  def promotions
    
  end
  
  def info_sponsors
    
  end
  
  def find_my_block
    if !current_user.blank?
      @user_rooms = Room.where(:user_id => current_user.id)
    else
      @user_rooms = ''
    end
    
    
  end
  

=begin
  def testimg
    @nonprofits = NonProfit.all
    
    
    url = 'http://localhost:3000/assets/blocks.css'
    css = StringIO.new( RestClient.get(url) )
    cssstring = css.string
    
    @nonprofits.each {|nonprofit|
      @non_profit = NonProfit.find_by_id(nonprofit.id)
      @rooms = @non_profit.rooms
      html_to_show = render_to_string :partial => 'blocks/blocks.html.erb'
      html_to_show = "<html><head><style>" + cssstring + "</style></head><body>" + html_to_show.gsub('<span class="img_placeholder"></span>', '<img src="http://localhost:3000/assets/MFS_Block_Image.jpg">') + "</body></html>"
      kit = IMGKit.new(html_to_show, quality: 50, zoom: 0.2)
      img = kit.to_img(:png)
      file = Tempfile.new(["template_#{nonprofit.id.to_s}", 'png'], 'tmp', :encoding => 'ascii-8bit')
      file.write(img)
      nonprofit.snapshot = file
      file.unlink
      nonprofit.save
    }
    
    @non_profit = NonProfit.find_by_id(1)
    @rooms = @non_profit.rooms

    html_to_show = render_to_string :partial => 'blocks/blocks.html.erb'
    html_to_show = "<html><head><style>" + cssstring + "</style></head><body>" + html_to_show.gsub('<span class="img_placeholder"></span>', '<img src="http://localhost:3000/assets/MFS_Block_Image.jpg">') + "</body></html>"
    kit = IMGKit.new(html_to_show, quality: 50, zoom: 0.2)
    #kit.stylesheets << 'http://localhost:3000/assets/home.css'
    

    # Get the binary image data
    #png = snap.to_bytes
    img = kit.to_img(:png)
    
    
    respond_to do |format|
      format.png do
        send_data(img, :type => "image/png", :disposition => 'inline')
      end
    end

  end
=end

end
