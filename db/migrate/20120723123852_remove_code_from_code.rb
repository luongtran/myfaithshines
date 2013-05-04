class RemoveCodeFromCode < ActiveRecord::Migration
  def up
    remove_column :codes, :code
      end

  def down
    add_column :codes, :code, :string
  end
end
