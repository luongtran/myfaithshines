class DogsController < ApplicationController


  def create
    puts '*****'
    puts 'Create'
    @dog = Dog.new(params[:dog])
    
    if @dog.save
      session[:dog_id] = @dog.id
      reserv = Reservation.find(session[:reservation_id])
      reserv.update_attribute(:dog_id, session[:dog_id])
      
      redirect_to review_path
    else
      session[:current_dog_name] = @dog.name  
      session[:current_dog_age] = @dog.age
      session[:current_dog_home] = @dog.home
#      session[:current_dog_motto] = @dog.motto
      session[:current_dog_more] = @dog.more

      full_message = []
      @dog.errors.each do |error, msg|
        full_message << msg
      end     
      
      puts 'flash'
      flash[:error] =  full_message.to_sentence
      
      redirect_to add_entity_path
    end
  end
  
  def update
    @dog = Dog.find(params[:dog][:id])
    if (@dog.dog_type_id == DogType.virtual.id && params[:dog][:dog_type_id] != DogType.virtual.id) || (@dog.dog_type_id != DogType.virtual.id && params[:dog][:dog_type_id] == DogType.virtual.id)
      params[:dog][:id] = nil
      @dog = Dog.new(params[:dog])
      if @dog.save
        session[:dog_id] = @dog.id
        reserv = Reservation.find(session[:reservation_id])
        reserv.update_attribute(:dog_id, session[:dog_id])
        
        redirect_to review_path
      else
        session[:current_dog_name] = @dog.name  
        session[:current_dog_age] = @dog.age
        session[:current_dog_home] = @dog.home
#       session[:current_dog_motto] = @dog.motto
        session[:current_dog_more] = @dog.more
  
        full_message = []
        @dog.errors.each do |error, msg|
          full_message << msg
        end     
        
        flash[:error] =  full_message.to_sentence
        
        redirect_to add_entity_path
      end
    else
      if @dog.update_attributes(params[:dog])
  
        session[:dog_id] = @dog.id
        reserv = Reservation.find(session[:reservation_id])
        reserv.update_attribute(:dog_id, session[:dog_id])
        
        redirect_to review_path
      else
        session[:current_dog_name] = @dog.name  
        session[:current_dog_age] = @dog.age
        session[:current_dog_home] = @dog.home
 #       session[:current_dog_motto] = @dog.motto
        session[:current_dog_more] = @dog.more
  
        full_message = []
        @dog.errors.each do |error, msg|
          full_message << msg
        end     
        
        puts 'flash'
        flash[:error] =  full_message.to_sentence
        
        redirect_to add_entity_path
      end
    end
    
    
  end
  
end
