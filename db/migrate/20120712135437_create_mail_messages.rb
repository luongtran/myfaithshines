class CreateMailMessages < ActiveRecord::Migration
  def change
    create_table :mail_messages do |t|
      t.boolean :all_users
      t.boolean :all_sponsors
      t.boolean :all_nonprofits
      t.text :addresses
      t.text :body
      t.text :other_mails
      t.string :subject

      t.timestamps
    end
  end
end
