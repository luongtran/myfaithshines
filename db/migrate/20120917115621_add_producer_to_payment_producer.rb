class AddProducerToPaymentProducer < ActiveRecord::Migration
  def change
    add_column :payment_producers, :associate_producer_id, :integer

  end
end
