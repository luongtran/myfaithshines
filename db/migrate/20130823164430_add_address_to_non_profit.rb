class AddAddressToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :address, :string
  end
end
