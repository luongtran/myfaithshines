class CreateNonProfitTypes < ActiveRecord::Migration
  def change
    create_table :non_profit_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
