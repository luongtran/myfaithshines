class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :reservation_counter
  helper_method :reservation_counter

  before_filter :store_location
  def store_location
    if (params[:find_my_block])
      url = #calculate the url here based on a params[:token] which you passed in
      session[:user_return_to] = find_my_block_path
    end
  end

  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    else
      stored_location_for(resource) || root_path
    end
    
  end

  def reservation_counter
    if !current_user.nil?
      reservation = Reservation.find_last_by_user_id(current_user.id)
      if !reservation.nil?
        puts 'Found reservation '+ reservation.id.to_s
        @time_left = (reservation.created_at + 20.minutes) - Time.now

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

      if !session[:cart_id].nil?
        @visible = true; 
        @visible = false if request.url == checkout_url       
      else
        @visible = false;  
     end
      
    end

  end
  
  def default_url_options
    if Rails.env.production?
      {:host => request.host }
    else  
      {}
    end
 end
  
end
