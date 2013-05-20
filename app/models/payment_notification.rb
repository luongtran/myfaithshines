class PaymentNotification < ActiveRecord::Base
  #belongs_to :reservation
  belongs_to :cart
  serialize :params
  after_create :mark_as_purchased

  
  def validate_gift(code_str, nonprofit_id)    
    code = Code.find(:first, :conditions => ['upper(code_value) = ? and active = ?', code_str.upcase, true])
    if (!code.nil? && code.non_profit_id.to_s.eql?(nonprofit_id.to_s) && code.redeemed > 0)
      return code
    else
      return nil
    end
  end

  private
  
  def mark_as_purchased
    if status == "Completed"
    
    cart = Cart.find(self.cart_id)
    cart.update_attribute(:purchased_at, Time.now)
    cart.save

    reserv = Reservation.where("cart_id=?", self.cart_id)
    user_for_mail = ""
    gifts = []   
    method = []
    total_price = 0
    number_blocks = 0
   
    reserv.each do |reservation| 
      puts "en reservation"
      #Update Code_gift 
     # gifts = []   
      option = RoomOption.find(reservation.room_option_id)   
      price = option.price.to_int
      
      gift_code_list = reservation.gift_codes.split(',')    
      if gift_code_list.nil?
        gift_code_list = []
      end
    
      gift_code_list.each do |code|    
            code = validate_gift(code, reservation.non_profit.id)   
              
            if !code.nil?
              gifts << code   
              if (code.redeem_value >= price)
                code.redeemed = code.redeemed - price
                price=0    
              else
                 price = price - code.redeem_value
                 code.redeemed = code.redeemed - code.redeem_value           
              end  
              
              code.save()  
               
              if (price == 0)
                break
              end   
            end                       
        end   
        
  
      room = Room.new
      room.x = reservation.x
      room.y = reservation.y
      room.width = reservation.width
      room.height = reservation.height
      room.user_id = reservation.user_id
      room.dog_id = reservation.dog_id
      room.non_profit_id = reservation.non_profit_id 
      if !reservation.associate_producer_id.nil?
        room.associate_producer_id = reservation.associate_producer_id
      end
      
      
      total_price += reservation.total_price
      user_for_mail = User.find(room.user_id)
      blocks = room.width * room.height
      number_blocks = number_blocks + blocks
      
      
       dog = Dog.find(room.dog_id)
       if dog.dog_type_id == DogType.virtual.id
         dog_type = "Virtual Dog"
       else
         dog_type = "Good Dog"
       end
          
      room.save
        
      gifts.each do |g|
         room_codes = RoomCode.new
         room_codes.room_id = room.id
         room_codes.code_id = g.id
         puts "Aca room"
         puts g
         
         room_codes.save
      end
      
         
      Reservation.destroy_all(["user_id = ?", reservation.user_id])
      
      if !room.associate_producer_id.nil?
        sold_block = SoldBlock.new
        sold_block.amount = price          
        sold_block.compensation_due = price*0.10.to_f
        sold_block.associate_producer_id = room.associate_producer_id
        sold_block.save
      end
     
      non_profit = NonProfit.find(room.non_profit_id)
      non_profit.update_flag = true
      non_profit.save
  

     #Email 2 Deliverable
      mail = MailMessage.new
      mail.subject = 'A gift for you!'   
      
      if dog.dog_type_id == DogType.virtual.id
        mail.attachments = File.read('public/certVirtualVD.pdf')
      else 
        if dog.dog_type_id == DogType.mydog.id
          mail.attachments = File.read('public/certGoodDogGD.pdf')
        else
          mail.attachments = File.read('public/certMemorialGD.pdf')
        end 
      end  
      user = User.find(room.user_id)
      mail.addresses = user.email if !user.email.blank? 
      mail.body = "Delivered"
    
      begin
        UserMailer.registration_confirmation_deliverable(mail).deliver if !user.email.blank? 
      rescue
      end

               
       if price == 0
         method = ["Gift Code"] + gifts.map{|gift| gift.code_value}
       else
         method = ["PayPal"] + gift_code_list
       end
         
    end
      
       #Email 1 Receipt   
       mail = MailMessage.new
       mail.subject = 'Email Receipt'
       mail.addresses = user_for_mail.email if !user_for_mail.email.blank?
       mail.body = "Receipt"
       num_blocks = 1

       begin
        if !user_for_mail.email.blank?
          UserMailer.registration_confirmation(mail, user_for_mail, transaction_id, total_price, number_blocks, method).deliver
        end
       rescue

       end
      
    
   end 
   
  end


end
