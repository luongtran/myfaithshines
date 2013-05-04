class AddNonProfitToRooms < ActiveRecord::Migration
  def change
      add_column :rooms, :non_profit_id, :integer
  end
end
