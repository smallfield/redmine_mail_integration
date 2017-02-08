class CreateMailMessages < ActiveRecord::Migration
  def change
    create_table :mail_messages do |t|
      t.belongs_to :issue
      t.text :message_id
    end
  end
end
