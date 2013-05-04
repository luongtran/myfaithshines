class AddAssociateProducerToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :associate_producer_id, :integer

  end
end
