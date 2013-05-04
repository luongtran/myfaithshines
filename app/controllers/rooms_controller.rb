class RoomsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @reservation = Reservation.find(params[:reservation_id])
    @room = Room.new
    @room.non_profit = @reservation.non_profit
    @room.x = @reservation.x
    @room.y = @reservation.y
    @room.width = @reservation.width
    @room.height = @reservation.height
    @room.user = current_user
    
    @time_left = (@reservation.created_at + 20.minutes) - Time.now 
    
    if @time_left > 0
            @minutes = "#{(@time_left / 60).to_i}"
            @seconds = "#{(@time_left % 60).to_i}"
            
            @minutes = "0#{@minutes}" if (@time_left / 60) < 10
            @seconds = "0#{@seconds}" if (@time_left % 60) < 10
    else
        @minutes = "00"
        @seconds = "00"
    end
    
  end
  
  def create
    reservation = Reservation.find(params[:reservation_id])
    room = Room.new
    room.non_profit = reservation.non_profit
    room.x = reservation.x
    room.width = reservation.width
    room.height = reservation.height
    room.user = current_user
    room.dog = Dog.find(1)
    
    if room.save
      Reservation.destroy_all(["user_id = ? ", current_user.id])
      redirect_to nonprofit_view_path(room.non_profit.id)
    end
  end
  
  def remove
    room_id = params[:id]  
    Room.where(:id => room_id).destroy_all
    
    render :json => {'valid' => true}
  end
  
end
