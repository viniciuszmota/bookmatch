class RemoveFirstAndSecondUserFromMatches < ActiveRecord::Migration[7.1]
  def change
    remove_reference :matches, :first_user, foreign_key: { to_table: :users }
    remove_reference :matches, :second_user, foreign_key: { to_table: :users }
  end
end
