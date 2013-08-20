class AddLatAndLngToNonProfit < ActiveRecord::Migration
  def change
    remove_column :non_profits, :latitude
    remove_column :non_profits, :longitude
    add_column :non_profits, :lat, :float
    add_column :non_profits, :lng, :float
  end
end
