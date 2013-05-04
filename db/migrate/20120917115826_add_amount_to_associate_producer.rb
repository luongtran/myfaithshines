class AddAmountToAssociateProducer < ActiveRecord::Migration
  def change
    add_column :associate_producers, :amount_owing, :float

    add_column :associate_producers, :amount_paid, :float

  end
end
