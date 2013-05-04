class ChangeTypeToNonProfit < ActiveRecord::Migration
  def up
    remove_column :non_profits, :non_profit_type
   	add_column :non_profits, :non_profit_type, :integer
	end
  def down
  	change_table :non_profits do |t|
      	t.change :non_profit_type, :string
    end
  end
end
