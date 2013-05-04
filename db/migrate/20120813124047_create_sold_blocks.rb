class CreateSoldBlocks < ActiveRecord::Migration
  def change
    create_table :sold_blocks do |t|
      t.integer :amount
      t.integer :compensation_due
      t.string :associate_producer_id

      t.timestamps
    end
  end
end
