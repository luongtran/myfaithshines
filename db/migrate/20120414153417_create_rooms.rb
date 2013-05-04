class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
