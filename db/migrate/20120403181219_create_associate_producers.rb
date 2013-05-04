class CreateAssociateProducers < ActiveRecord::Migration
  def change
    create_table :associate_producers do |t|
      t.string :name
      t.string :email
      t.string :site
      t.text :notes

      t.timestamps
    end
  end
end
