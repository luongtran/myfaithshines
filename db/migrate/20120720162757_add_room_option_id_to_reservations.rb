class AddRoomOptionIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :room_option_id, :integer

  end
end
