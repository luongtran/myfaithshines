class CreateNonProfits < ActiveRecord::Migration
  def change
    create_table :non_profits do |t|
      t.string :name
      t.string :email
      t.string :site

      t.timestamps
    end
  end
end
