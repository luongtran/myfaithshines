class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :token
      t.string :identifier
      t.integer :non_profit_id
      t.boolean :recurring
      t.boolean :digital
      t.boolean :popup
      t.boolean :completed
      t.boolean :canceled

      t.timestamps
    end
  end
end
