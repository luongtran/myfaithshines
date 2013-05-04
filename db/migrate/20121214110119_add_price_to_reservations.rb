class AddPriceToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :block_price, :float
    add_column :reservations, :total_price, :float
  end
end
