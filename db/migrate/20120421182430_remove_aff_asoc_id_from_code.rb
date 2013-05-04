class RemoveAffAsocIdFromCode < ActiveRecord::Migration
  def up
    remove_column :codes, :aff_assoc_id
    remove_column :codes, :aff_assoc_type
  end

  def down
    add_column :codes, :aff_assoc_id, :integer
    add_column :codes, :aff_assoc_type, :string
  end
end
