class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :link
      t.integer :gender_id
      t.integer :age
      t.string :home
      t.string :motto
      t.text :more
      t.integer :dog_type_id

      t.timestamps
    end
  end
end
