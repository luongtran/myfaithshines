class AddGiftCodesToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :gift_codes, :string

  end
end
