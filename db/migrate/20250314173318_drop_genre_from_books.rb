class DropGenreFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :genre_id
  end
end
