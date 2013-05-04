class RoomCodes < ActiveRecord::Migration
  def change
    create_table :room_codes do |t|
      t.integer :room_id
      t.integer :code_id
      
      t.timestamps
    end
  end
end
