class ModifyMessagesTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :sender, foreign_key: { to_table: :users }
    remove_reference :messages, :receiver, foreign_key: { to_table: :users }
    add_reference :messages, :user, foreign_key: true
    add_reference :messages, :match, foreign_key: true
  end
end