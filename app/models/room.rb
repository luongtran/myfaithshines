
class Room < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog
  belongs_to :non_profit
  has_many :room_codes
  has_many :codes, :through => :room_codes
  accepts_nested_attributes_for :room_codes 
end
