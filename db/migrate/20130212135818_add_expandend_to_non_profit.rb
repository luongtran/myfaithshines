class AddExpandendToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :expanded, :boolean
  end
end
