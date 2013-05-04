class RemoveCodeTypeFromCode < ActiveRecord::Migration
  def up
    remove_column :codes, :code_type
      end

  def down
    add_column :codes, :code_type, :string
  end
end
