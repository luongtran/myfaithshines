class ChangeColumnSoldBlocks < ActiveRecord::Migration
  def up
    remove_column :sold_blocks, :associate_producer_id
    add_column :sold_blocks, :associate_producer_id, :integer
  end

end
