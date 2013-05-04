class ChangeColumnCarts < ActiveRecord::Migration
  def up
    rename_column :carts, :reservation_id, :user_id
  end

  def down
    rename_column :carts, :user_id, :reservation_id
  end
end
