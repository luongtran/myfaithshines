class ChangeColumnToPaypalNotifications < ActiveRecord::Migration
 def up
    rename_column :payment_notifications, :reservation_id, :cart_id
  end

  def down
    rename_column :payment_notifications, :cart_id, :reservation_id
  end
end
