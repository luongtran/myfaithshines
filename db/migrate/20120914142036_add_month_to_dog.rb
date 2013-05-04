class AddMonthToDog < ActiveRecord::Migration
  def change
    add_column :dogs, :month, :integer

  end
end
