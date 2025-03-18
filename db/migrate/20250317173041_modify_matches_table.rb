class ModifyMatchesTable < ActiveRecord::Migration[7.1]
  def change
     # Deletando todas as colunas da tabela matches
     remove_column :matches, :status, :string
     remove_column :matches, :requestee_id, :bigint
     remove_column :matches, :attendee_id, :bigint

     add_reference :matches, :first_user, foreign_key: { to_table: :users }
     add_reference :matches, :second_user, foreign_key: { to_table: :users }
   end
end
