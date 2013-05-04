ActiveAdmin.register NonProfit do
  # menu :priority => 5
  config.comments = false
    # /admin/non_profits/:id/b
    member_action :blocks do
      @non_profit = NonProfit.find(params[:id])
      @rooms = @non_profit.rooms
      @reservations = Reservation.active.find(:all,  :conditions => "non_profit_id = #{@non_profit.id}")
    
      # This will render app/views/admin/posts/comments.html.erb
    end

end
  
 