class AddLatitudeAndLongitudeToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :latitude, :float
    add_column :non_profits, :longitude, :float
    add_column :non_profits, :zipcode, :string
  end
end
