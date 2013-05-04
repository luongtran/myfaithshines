class Reservation < ActiveRecord::Base

  belongs_to :non_profit
  belongs_to :user
  belongs_to :cart
  
  attr_accessor :gift_code
  #scope :active, where("created_at >= ?", Time.now - 20.minutes) 
  scope :active, lambda {where( "created_at > ? ", DateTime.now - 20.minutes) }
end
