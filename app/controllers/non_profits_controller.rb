class NonProfitsController < ApplicationController
  #before_filter :authenticate_user!

 
  def show
    @non_profit = NonProfit.find_by_id(params[:id])    
    @non_profit_sp_list = @non_profit.sponsors.sort_by(&:name)

    @non_profit_sp =  @non_profit.sponsors.where(:featured => true)
    #snapshot = Snapshot.new
     
    #@non_profit.save_snapshot
    @rooms = @non_profit.rooms
    
    sum = Room.sum('width*height', :conditions => {:non_profit_id => params[:id]}).to_i

    if !@rooms.nil?
       if sum > 300
        @non_profit.expanded = true;
        @non_profit.update_attribute(:expanded, true)
      end
    end
    
    
    @reservations = Reservation.active.find(:all,  :conditions => "non_profit_id = #{@non_profit.id}")
    
    if params[:dog_id].blank? 
      session.delete(:dog_id)
    end
    
    if !params[:selection_room].blank?
      @selection_room = params[:selection_room]  
    end

  end
  
   #==========================================
   # Search by Name
   # params: keyword
   #==========================================
  
  def search_by_name
    @non_profits = NonProfit.where("name like '%#{params[:keyword]}%'")
    respond_to do |format|
      format.js
    end
  end
   
  def select      
  
    if !params[:dog_id].blank?
      session[:dog_id] = params[:dog_id]
     redirect_to nonprofit_with_dog_view_path(params[:id], params[:dog_id])     
    else     
      session.delete(:dog_id)
       redirect_to nonprofit_view_path(params[:id])      
    end 
   
  end
  
  
  def save_snapshot
    non_profit = NonProfit.find_by_id(params[:non_profit_id]) 
    puts non_profit
    #Heroku
    #url = request.protocol()+request.host_with_port  + '/blocks_for_snapshot.css'
    #url = request.protocol()+request.host_with_port  + '/assets/blocks.css'
    #css = StringIO.new( RestClient.get(url) )
    #cssstring = css.string
    
    selection_room = params[:selection_room]
    if selection_room.blank?
      selection_room = ""
    end
    
    puts "selection" + selection_room
    
    cssstring = 'p{margin:0}.lateral{font-size:14px;font-weight:700;color:#d3d3d3}.dog a,.dog-readonly a{background:url(../assets/MFS_Block_Image.jpg);float:left;height:40px;width:40px;z-index:1}.dog-title-up{float:left;width:40px;z-index:1;text-align:center}.dog-title-right{float:right;z-index:1;text-align:center;list-style-type:none;padding:0;margin:0;margin-top:20px}.dog-title-right li{height:30px;padding-top:10px;width:20px}.dog a:hover{background:url(../assets/buy.png)}#wrapper{margin-bottom:20px}#wrapper table tr>td:first-child{width:30px}#wrapper .blocks_wrapper{width:800px;margin:0 auto}#grid-content{width:820px}#grid-headers{width:840px;position:relative}#grid-container,#grid-container-readonly{width:800px;float:left;position:relative}#grid-content-readonly{width:820px}#grid-content-readonly .selected{border:2px solid orange}#grid-content-readonly .place_option{position:absolute;z-index:999;background-color:lightslategrey;width:97px;height:130px}#grid-content-readonly .place_option_button{width:80px;margin-top:10px;margin-left:7px;cursor:pointer}.ui-tooltip-content{line-height:16px;font-size:16px;font-weight:700;background:#fff}#simplemodal-container{border:solid 1px #d3d3d3!important}#simplemodal-container a.modal-close{background:url(x.png) no-repeat;width:25px;height:29px;display:inline;z-index:3200;position:absolute;top:-15px;right:-18px;cursor:pointer}'
    reservations = Reservation.active.find(:all,  :conditions => ['non_profit_id = ?',non_profit.id ])
    
    # This was a quick workaround for an error. The partial should use only local variables
    @non_profit = non_profit
    html_to_show = render_to_string :partial => 'blocks/blocks.html.erb' , :layout=>false, :locals=>{:rooms=> non_profit.rooms, :non_profit => non_profit, :reservations => reservations, :selection_room => !selection_room.blank? ? selection_room : "" }
    html_to_show = "<html><head><style>" + cssstring + "</style></head><body>" + html_to_show.gsub('<span class="img_placeholder"></span>', '<img src="' +  request.protocol()+request.host_with_port + '/assets/MFS_Block_Image.jpg">').gsub('src="/assets/MFS_Block_Image_Reserved.jpg"','src="' +  request.protocol()+request.host_with_port + '/assets/MFS_Block_Image_Reserved.jpg"' ) + "</body></html>"
    kit = IMGKit.new(html_to_show, quality: 40, zoom: 0.2)
    img = kit.to_img(:png)
    

    file = Tempfile.new(["template_#{non_profit.id.to_s}", 'png'], 'tmp', :encoding => 'ascii-8bit')
    file.write(img)
    file.flush
    non_profit.snapshot = file
    non_profit.save
    
    file.unlink
    
    render :json => {'success' => true}
  end
  
  def blocks_readonly
    @non_profit = NonProfit.find(params[:id])
    @rooms = @non_profit.rooms
    @reservations = Reservation.active.find(:all,  :conditions => "non_profit_id = #{@non_profit.id}")
    
  end

  def new

  end
  
end
