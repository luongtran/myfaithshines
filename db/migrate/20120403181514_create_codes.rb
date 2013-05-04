class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code_value
      t.integer :sponsor_id
      t.integer :non_profit_id
      t.string :code
      t.string :code_type
      t.integer :total_value
      t.integer :redeem_value
      t.integer :redeemed

      t.boolean :active

      t.timestamps
    end
  end
end
