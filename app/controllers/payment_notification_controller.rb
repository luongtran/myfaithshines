class PaymentNotificationController < ApplicationController
  
  protect_from_forgery :except => [:create]
  
  def create 
    pn = PaymentNotification.create!(:params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id]) 
    puts 'Payment =' + pn.to_json
    render :nothing => true
  end

end
