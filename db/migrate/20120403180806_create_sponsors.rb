class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :email
      t.string :site
      t.integer :state_id

      t.timestamps
    end
  end
end
