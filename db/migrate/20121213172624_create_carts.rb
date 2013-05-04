class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :reservation_id
      
      t.timestamps
    end
  end
end
