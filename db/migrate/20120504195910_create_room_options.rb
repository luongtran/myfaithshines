class CreateRoomOptions < ActiveRecord::Migration
  def change
    create_table :room_options do |t|
      t.integer :width
      t.integer :height
      t.float :price

      t.timestamps
    end
  end
end
