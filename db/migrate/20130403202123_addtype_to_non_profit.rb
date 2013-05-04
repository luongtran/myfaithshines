class AddtypeToNonProfit < ActiveRecord::Migration
  
  def change
  	  add_column :non_profits, :non_profit_type, :string
  end

end
