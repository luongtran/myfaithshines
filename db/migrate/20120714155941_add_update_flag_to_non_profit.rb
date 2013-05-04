class AddUpdateFlagToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :update_flag, :boolean
    NonProfit.update_all ["update_flag = ?", false]
  end
end
