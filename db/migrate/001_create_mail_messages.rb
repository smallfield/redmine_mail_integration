class CreateMailMessages < ActiveRecord::Migration
  def change
    create_table :mail_messages do |t|
      t.belongs_to :issue, index: true, foreign_key: true
      t.text :message_id
    end
  end
end
