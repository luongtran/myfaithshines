class RenameNonProfitType < ActiveRecord::Migration
  def up
  	 rename_column :non_profits, :non_profit_type, :non_profit_type_id
  end

  def down
  	rename_column :non_profits, :non_profit_type_id, :non_profit_type
  end
end
