class AddAttachmentsToMailMessages < ActiveRecord::Migration
  def change
    add_column :mail_messages, :attachments, :string

  end
end
