class AddDogIdToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :dog_id, :integer

  end
end
