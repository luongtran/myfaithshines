class BlocksController < ApplicationController

  def view_dog
    @room = Room.find(params[:id]) 
    puts "HOLAAAA" + @room.codes.to_s
    html_string = render_to_string :layout => false
    render :json => {:html => html_string}
  end
  
  def preview_dog
    @reserv = Reservation.find(params[:id])
    @dog = Dog.find(@reserv.dog_id)
    
    html_string = render_to_string :layout => false
    render :json => {:html => html_string}
  end

  
end
