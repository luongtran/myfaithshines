class RoomCode < ActiveRecord::Base
  belongs_to :room
  belongs_to :code
end
