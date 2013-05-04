class AddccToMailMessages < ActiveRecord::Migration
  def change
      add_column :mail_messages, :cc, :string
      add_column :mail_messages, :bcc, :string
  end

end
