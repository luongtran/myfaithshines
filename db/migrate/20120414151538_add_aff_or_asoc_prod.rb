class AddAffOrAsocProd < ActiveRecord::Migration
  def up
    add_column :codes, :aff_assoc_id, :integer
    add_column :codes, :aff_assoc_type, :string
  end

  def down
    remove_column :codes, :aff_assoc_id
    remove_column :codes, :aff_assoc_type
  end
end
