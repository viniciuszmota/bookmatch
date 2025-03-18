class AddFirstLikeAndSecondLikeToMatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :matches, :first_like, foreign_key: { to_table: :likes }
    add_reference :matches, :second_like, foreign_key: { to_table: :likes }
  end
end
