class RoomOption < ActiveRecord::Base
     attr_accessible :width, :height, :price
     attr_accessor :enabled
end
