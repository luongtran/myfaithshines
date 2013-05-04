class AddCategoryToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :category, :string

  end
end
