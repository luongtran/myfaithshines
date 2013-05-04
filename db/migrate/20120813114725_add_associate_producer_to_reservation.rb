class AddAssociateProducerToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :associate_producer_id, :integer

  end
end
