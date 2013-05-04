class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.integer :non_profit_id

      t.timestamps
    end
  end
end
