class AddSenderAndReceiverToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :sender, foreign_key: { to_table: :users }
    add_reference :messages, :receiver, foreign_key: { to_table: :users }
  end
end
