class AddStatusToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :status, :string
  end
end
