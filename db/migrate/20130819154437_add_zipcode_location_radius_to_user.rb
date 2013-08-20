class AddZipcodeLocationRadiusToUser < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string
    add_column :users, :location_radius, :integer
  end
end
