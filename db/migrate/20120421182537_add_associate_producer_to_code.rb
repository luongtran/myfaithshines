class AddAssociateProducerToCode < ActiveRecord::Migration
  def change
        add_column :codes, :associate_producer_id, :integer
  end
end
