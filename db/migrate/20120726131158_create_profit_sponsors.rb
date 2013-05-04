class CreateProfitSponsors < ActiveRecord::Migration
  def change
    create_table :profit_sponsors do |t|
      t.integer :non_profit_id
      t.integer :sponsor_id

      t.timestamps
    end
  end
end
