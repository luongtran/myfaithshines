class AddSnapshotToNonProfit < ActiveRecord::Migration
  def self.up
    add_column :non_profits, :snapshot_file_name, :string
    add_column :non_profits, :snapshot_content_type, :string
    add_column :non_profits, :snapshot_file_size, :integer
    add_column :non_profits, :snapshot_updated_at, :datetime
  end

  def self.down
    remove_column :non_profits, :snapshot_file_name
    remove_column :non_profits, :snapshot_content_type
    remove_column :non_profits, :snapshot_file_size
    remove_column :non_profits, :snapshot_updated_at
  end
end
