class CreatePaymentProducers < ActiveRecord::Migration
  def change
    create_table :payment_producers do |t|
      t.date :date
      t.integer :amount

      t.timestamps
    end
  end
end
