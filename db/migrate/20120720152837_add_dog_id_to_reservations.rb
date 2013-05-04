class AddDogIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :dog_id, :integer

  end
end
