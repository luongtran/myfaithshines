class AddStateToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :state_id, :integer

  end
end
