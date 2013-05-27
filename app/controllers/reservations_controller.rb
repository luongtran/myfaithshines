class ReservationsController < ApplicationController
  include Snapshot
  before_filter :authenticate_user!

  def new
    session[:gift_codes] = ''
    @room_options = RoomOption.all
    @non_profit = NonProfit.find(params[:non_profit_id])
    @x = params[:x]
    @y = params[:y]
    
    session[:x] = @x
    session[:y] = @y
    session[:non_profit_id] = @non_profit.id
    
    @has_gifts= false
    @redirect = add_entity_path
    
    if !params[:reserve_id].nil?
      @my_reserve = Reservation.find(params[:reserve_id])          
      @create_new = false           
      @has_gifts = @my_reserve.gift_codes.length > 0             
    else params[:reserve_id].nil?
      @create_new = true
    end   

    @isFundRaiser = false
    myString = "NP Fund"
    if !@non_profit.non_profit_type.nil? and @non_profit.non_profit_type.name.include?(myString)
       @isFundRaiser = true   
    end

    #if !session[:dog_id].blank?    
    #  @create_new = true    
    #else
    #    @create_new = true        
    #end          
    reservations = Reservation.active
    rooms = @non_profit.rooms
  
    @room_options.each do |option| 
            if option.width + params[:x].to_i > 21 or option.height + params[:y].to_i > 21
                if option.width + params[:x].to_i > 26 or option.height + params[:y].to_i > 26 #check if non_profit is expanded
                    option.enabled = false              
                else
                    option.enabled = true
                end      
            else
               option.enabled = true
            end
            
            intersect = false
       
            reservations.each do |reservation|                  
              if !params[:reserve_id].nil? ? res = @my_reserve.id : res = ''                                    
                if !reservation.id = res                                             
                      option_square_topLeft_x = params[:x].to_i #16
                      option_square_topLeft_y = params[:y].to_i #1
                      option_square_bottomRight_x = params[:x].to_i + option.width #21
                      option_square_bottomRight_y = params[:y].to_i + option.height #6
                      
                      reservation_square_topLeft_x = reservation.x #17
                      reservation_square_topLeft_y = reservation.y #1
                      reservation_square_bottomRight_x = reservation.x + reservation.width #21
                      reservation_square_bottomRight_y = reservation.y + reservation.height #5


                      if ( option_square_topLeft_x >= reservation_square_bottomRight_x or
                           option_square_bottomRight_x <= reservation_square_topLeft_x or
                           option_square_topLeft_y >= reservation_square_bottomRight_y or
                           option_square_bottomRight_y <= reservation_square_topLeft_y )
                              intersect = false
                      else
                              intersect = true
                              break
                      end                        
                  end   
                end
            end     
            
            if !(intersect) and !rooms.nil?
                    rooms.each do |room| 
                            option_square_topLeft_x = params[:x].to_i
                            option_square_topLeft_y = params[:y].to_i
                            option_square_bottomRight_x = params[:x].to_i + option.width
                            option_square_bottomRight_y = params[:y].to_i + option.height
                            
                            room_square_topLeft_x = room.x
                            room_square_topLeft_y = room.y
                            room_square_bottomRight_x = room.x + room.width 
                            room_square_bottomRight_y = room.y + room.height
                            
                            if ( option_square_topLeft_x >= room_square_bottomRight_x or
                                 option_square_bottomRight_x <= room_square_topLeft_x or
                                 option_square_topLeft_y >= room_square_bottomRight_y or
                                 option_square_bottomRight_y <= room_square_topLeft_y )
                                    intersect = false
                            else
                                    intersect = true
                                    break
                            end 
                    end
            end                
            option.enabled = !(intersect) if option.enabled
    end

    
  end
  
  def new_reserve  
   
   session[:room_option_id] = params[:room_option_id]
   last_reserv = Reservation.find_last_by_user_id(current_user.id)
   if !last_reserv.nil?
     time_left = (last_reserv.created_at + 20.minutes) - Time.now
     if time_left <= 0          
       cart_id = last_reserv.cart_id 
       Reservation.destroy_all(["user_id = ?", current_user.id])   
       Cart.destroy_all(["user_id = ?", current_user.id])   
     
       session[:cart_id] = nil
     else
       session[:cart_id] = last_reserv.cart_id     
     end   
   end
   

    reservation = Reservation.new
    reservation.x = session[:x]
    reservation.y = session[:y]
    
    option = RoomOption.find(params[:room_option_id])
    
    reservation.width = option.width
    reservation.height = option.height
    reservation.user = current_user
    reservation.non_profit = NonProfit.find(session[:non_profit_id])
    reservation.room_option_id = session[:room_option_id]
    reservation.gift_codes = session[:gift_codes]
    
    if !session[:dog_id].blank?
      reservation.dog_id = session[:dog_id]
    end
      
    puts 'Going to save'
    if reservation.save
        #Destroying the unused reservations for that user
        
        puts 'Updating flag for non profit: ' + reservation.non_profit.id.to_s
        reservation.non_profit.update_flag = true;
        reservation.non_profit.save
        
       
        #Reservation.destroy_all(["user_id = ? and id != ?", current_user.id, reservation.id])
        session[:reservation_id] = reservation.id
        #save_snapshot(url = request.protocol()+request.host_with_port  + '/save_snapshot/' + reservation.non_profit.id.to_s)
        #reservation.non_profit.delay.makeSnapshotRequest(request.protocol()+request.host_with_port  + '/save_snapshot/' + reservation.non_profit.id)
        
        
        render :json => {'success' => true}
    else
      params[:x] = reservation.x
      params[:y] = reservation.y
      params[:non_profit_id] = session[:non_profit_id]
      render :json => {'success' => false}
    end
  end
  
  def update_reserve 
    session[:room_option_id] = params[:room_option_id]
    option = RoomOption.find(params[:room_option_id])
       
    if !session[:reservation_id].nil?   
      reserve = Reservation.find(session[:reservation_id])      
      reserve.room_option_id = session[:room_option_id].to_i
      reserve.gift_codes = session[:gift_codes]
      reserve.width = option.width
      reserve.height = option.height
      reserve.save

      render :json => {'success' => true}
           
    end
    
  end
  
  def add_entity
    @virtual_dogs = Dog.getRandomVirtual


    if !session[:dog_id].nil?
      @dog = Dog.find(session[:dog_id])
    else
      @dog = Dog.new   
      @dog.name = session[:current_dog_name]
      @dog.age = session[:current_dog_age]
      @dog.home = session[:current_dog_home]
#      @dog.motto = session[:current_dog_motto]
      @dog.more = session[:current_dog_more]
      @dog.dog_type = DogType.mydog
    end
    
    session[:current_dog_name] = ''
    session[:current_dog_age] = ''
    session[:current_dog_home] = ''
#    session[:current_dog_motto] = ''
    session[:current_dog_more] = ''
  end
  
  def create
        reservation = Reservation.new
        reservation.x = params[:x]
        reservation.y = params[:y]
        reservation.width = params[:width]
        reservation.height = params[:height]
        reservation.user = current_user
        reservation.non_profit = NonProfit.find(params[:non_profit_id])
            
        if reservation.save
                #Destroying the unused reservations for that user 
               # Reservation.destroy_all(["user_id = ? and id != ?", current_user.id, reservation.id])
                
                redirect_to new_room_path(reservation) 
        else
                render 'new'
        end
  end
  
  def validate_gift(code_str, nonprofit_id)
   
    #code = nil
    #st = code_str.upcase.to_s

    #if !session[:reservation_codes].blank?
     # session[:reservation_codes].each do |r_code|
      #  if r_code.code_value.to_s.eql?(st.to_s)
         # code = r_code
       # end
      #end
    #end

    #if !session[:cart_id].blank?
     # cart = Cart.find(session[:cart_id])
      #rev_list = cart.reservations
      #puts "REV LIST" + rev_list.to_s
      #code_list = []
      
      #rev_list.each do |rev|
        #if rev.gift_code.code_value.to_s.eql?(st.to_s)      
        #  code_list << rev
        #  rev.redeemed -= rev.gift_code.redeem_value
        #  puts "REDDDDD" + rev.redeemed.to_s
        #end
      #end
    #end

    #if code.blank?
    code = Code.find(:first, :conditions => ['upper(code_value) = ? and active = ?', code_str.upcase, true])
    #end

    if (!code.nil? && code.non_profit_id.to_s.eql?(nonprofit_id.to_s) && code.redeem_value > 0)
      return code
    else
      return nil
    end
  end
  
  def validate_gift_code

    nonprofit_id = params[:non_profit_id]
    gift_code = params[:gift_code]
    
    code = validate_gift(gift_code, nonprofit_id)
    if !code.nil?
    code_is_empty = false

      redeemed = code.redeemed

       if !session[:cart_id].blank?
         cart = Cart.first(:conditions=>{:id=> session[:cart_id]})
         if !cart.nil?
            reserv_list = Reservation.where("cart_id=?", cart.id)    
             reserv_list.each do |res|   
                if res.gift_codes.upcase.to_s == code.code_value.to_s
                  redeemed -= code.redeem_value
                  if redeemed <= 0   
                    code_is_empty = true;
                    break
                  end
                end
            end
         else
           session[:cart_id] = nil
         end    
      end
    end
    
    non_profit = NonProfit.find(params[:non_profit_id])
    
    if !non_profit.non_profit_type.nil? and non_profit.non_profit_type.name.include?("NP Fund") and !code.nil? 
      option_id = convert_code_value_to_blocks(params[:non_profit_id], code)
       
       if !option_id.blank?
         option = RoomOption.find(option_id)
         option.blank?
         inblock =  "#{option.width}x#{option.height}"
      end
      
    end

    if (!code.nil?)
      #if in_cart
        if !inblock.blank?
          render :json => {'valid'=> true, 'code_is_empty' => code_is_empty, 'remaining_value'=> code.redeemed, 'redeem_value'=> code.redeem_value, 'showInBlocks' => inblock, 'option_id' => option_id }
        else
          render :json => {'valid'=> true, 'code_is_empty' => code_is_empty, 'remaining_value'=> code.redeemed, 'redeem_value'=> code.redeem_value, 'showInBlocks' => "", 'option_id' => ""}
        end
      #else
       # if !inblock.blank?
       #   render :json => {'valid'=> true, 'code_is_empty' => code_is_empty, 'remaining_value'=> code.redeemed, 'redeem_value'=> code.redeem_value ,'showInBlocks' => inblock, 'option_id' => option_id}  
       # else
       #   render :json => {'valid'=> true, 'code_is_empty' => code_is_empty, 'remaining_value'=> code.redeemed, 'redeem_value'=> code.redeem_value,'showInBlocks' => "", 'option_id' => ""}  
       # end
      #end
    else
      render :json => {'valid'=> false}
    end
    
  end

 def validate_gift_code_list
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    gift_codes = params[:gift_codes]
    gift_arr = gift_codes.split(/,/).uniq
      
    error = false;

    code = validate_gift(gift_codes, params[:non_profit_id])
    if code.blank? || code.redeemed <= 0
      error = true
    else

      redeemed = code.redeemed

      if !session[:cart_id].blank? 
        cart = Cart.find(session[:cart_id])
        reserv_list = Reservation.where("cart_id=?", cart.id)    
        reserv_list.each do |res|   
          if res.gift_codes.upcase.to_s == code.code_value.to_s
            redeemed -= code.redeem_value
            if redeemed <= 0   
              error = true
              break
            end
          end
        end
      end  
    end

    non_profit = NonProfit.find(params[:non_profit_id])
    if !non_profit.non_profit_type.nil? and non_profit.non_profit_type.name.include?("NP Fund") and gift_codes.blank?
      error = true
    end    


    if (!error)
      session[:gift_codes] = gift_arr.join(",")        
      render :json => {'valid'=> true}
    else
      session[:gift_codes] = ''
      render :json => {'valid'=> false}
    end
    
  end

  def convert_code_value_to_blocks(non_profit_id, code)
    option_id = ""
    non_profit = NonProfit.find(non_profit_id)
    if !non_profit.non_profit_type.nil? and non_profit.non_profit_type.name.include?("NP Fund") 
        room_options = RoomOption.all
        room_options.each do |option| 
          if code.redeem_value == option.price.to_int
            option_id = option.id
          else
            if code.redeem_value > option.price.to_int
              option_id = option.id
            end
          end
        end
    end

    option_id
  end
  
  def validate_block_option
    code = validate_gift(params[:gift_code], params[:non_profit_id])
    block_option = RoomOption.find(params[:option_id])

    error = false;
    inblock = ""

    non_profit = NonProfit.find(params[:non_profit_id])
   
    if !non_profit.non_profit_type.nil? and non_profit.non_profit_type.name.include?("NP Fund") and !code.nil?
      option_id = convert_code_value_to_blocks(params[:non_profit_id], code)
      
      if !option_id.nil?
        option = RoomOption.find(option_id)
        inblock = "#{option.width}x#{option.height}"
      end

      if !inblock.include?("#{block_option.width}x#{block_option.height}")
        error = true
      end
    end
    
  
    
    if (!error)
      render :json => {'valid' => true}
    else
      render :json => {'valid' => false}
    end

  end
  
  def add_dog  
    session[:dog_id] = params[:dog_id]   
    reserv = Reservation.find(session[:reservation_id])
    reserv.update_attribute(:dog_id, session[:dog_id])
    render :json => {'success'=> true}
  end
  
  def review
    @reservation_id = session[:reservation_id]    
    @dog = Dog.find(session[:dog_id])
    @associate_producer = AssociateProducer.all
    
      if (!@reservation_id.nil?)
        @rev = Reservation.find(@reservation_id)  
      end
    
    option = RoomOption.find(session[:room_option_id])
    
    @final_price = 0
    @sum_gift = 0
    @gift_list = []
   
    price = option.price.to_int
    @total_price = price
    
    gift_code_list = session[:gift_codes].split(',')   
    puts '=============='
    puts gift_code_list
    gift_code_list.each do |g|     
        code = validate_gift(g, session[:non_profit_id] )
      
        if ( !code.nil? && code.redeem_value > 0)                                
           if (@sum_gift + code.redeem_value >= price)
              @final_price = 0                     
           end                                                                               
          @sum_gift += code.redeem_value                                                           
        end           
    end
 
    if (price > @sum_gift)
      @final_price = price - @sum_gift
    end
   
    @rev.update_attribute(:block_price,price)
    @rev.update_attribute(:total_price, @final_price)
    @rev.save
    
    npFundCode = nil
    gift_code_list.each do |code|    
        code = validate_gift(code, session[:non_profit_id] )            
        gift = Code.new              
        gift.total_value = code.total_value
        gift.code_value = code.code_value
        
        if (price != 0)     
          if (code.redeem_value >= price)           
            code.redeemed = code.redeemed - price
            price = 0                
          else
             price = price - code.redeem_value
             code.redeemed = code.redeemed - code.redeem_value
          end         
        end      
        gift.redeem_value = code.redeem_value 
        gift.redeemed = code.redeemed
        gift.non_profit_id = code.non_profit_id

        npFundCode = code
        @rev.gift_code = code

        @gift_list.push(gift)                                   
    end

    #session[:reservation_codes] = @gift_list

    if !@rev.non_profit.non_profit_type.nil?
      
     if @rev.non_profit.non_profit_type.name.include?("NP Fund") and !npFundCode.blank?
        option_id = convert_code_value_to_blocks(session[:non_profit_id], npFundCode)
         if !option_id.blank?
           option = RoomOption.find(option_id)
           @blockCode =  "#{option.width}x#{option.height}"

          # session[:reservation_codes] = npFundCode

        end
      end  
    end

    
  end  
  
  def add_to_cart

    if !(session[:reservation_id].nil?)
      res = Reservation.find(session[:reservation_id])
      
      if !session[:cart_id].nil?
        cart = Cart.find(session[:cart_id])
        session[:cart_id] = nil if !cart.purchased_at.nil?
      end
      if session[:cart_id].nil?
        cart = Cart.new
        cart.user_id = current_user.id
        cart.save
        session[:cart_id] = cart.id
      end

      cart.reservations << res
      cart.save
      
      redirect_to root_path
     
    end    
  end
  
  def checkout
    if !session[:reservation_id].nil?
      res = Reservation.find(session[:reservation_id]) 
      
      if !session[:cart_id].nil? 
          cart = Cart.first(:conditions=> {:id => session[:cart_id]})
          if !cart.nil?
            session[:cart_id] = nil if !cart.purchased_at.nil?
          else
            session[:cart_id] = nil 
          end
          
      end
      if session[:cart_id].nil?
          cart = Cart.new
          cart.user_id = current_user.id
          cart.save
          session[:cart_id] = cart.id
      end    
     
      cart.reservations << res
      cart.save
       
    end

    @reserv_list = []
    @reserv_list = Reservation.where("cart_id=?", session[:cart_id])
      
    @cart = Cart.find(session[:cart_id])
     
    @total_due = 0
    
    @reserv_list.each do |r|
       @total_due += r.total_price if !r.total_price.nil? 
    end
        
    (@total_due == 0) ?  @payment_method = 'Gift Code' : @payment_method = 'Paypal'     
    
    if session[:reservation_id].nil? && @reserv_list.count <= 0
      session[:cart_id] = nil
      redirect_to root_path      
    end
 
  end
  
  def confirm_purchase    
    if !(session[:cart_id].nil?)
      cart = Cart.find(session[:cart_id])    
      if !(cart.nil?)  and PaymentNotification.find_by_cart_id(session[:cart_id]).nil?
        puts "=== " + cart.to_s
       PaymentNotification.create!(:params => params, :cart_id => session[:cart_id], :status => 'Completed', :transaction_id => '9PJ82176XH868184S')                        
      end        
    end
   redirect_to confirm_room_path  
  end
  
  
  def delete_reservation
    if !params[:reservation_id].blank?
      reservation = Reservation.find(params[:reservation_id])
     
      if session[:reservation_id].to_s == params[:reservation_id].to_s
         session[:reservation_id] = nil
        # session[:reservation_codes] = nil
      end
       
      Reservation.destroy_all(["user_id = ? and id = ?", current_user.id, params[:reservation_id]])
      
      redirect_to checkout_path
    end 
  end
  
  def save_ap
     reserv = Reservation.find(params[:reservation_id])      
     p = params[:associate_producer_id]
     cero = 0
      if !reserv.nil?  
        if params[:associate_producer_id].to_i > 0
          reserv.update_attribute(:associate_producer_id, params[:associate_producer_id])
          reserv.save
        else
          reserv.update_attribute(:associate_producer_id, "")
          reserv.save
        end           
       render :json => {'success'=> true}
      end
  end
  
  
  def confirmation_room
    session[:reservation_id] = nil
    session[:cart_id] = nil
    puts "destroy CART"
    Cart.destroy_all(["user_id = ?", current_user.id])
  end
  
end
