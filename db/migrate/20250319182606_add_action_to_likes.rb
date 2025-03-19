class AddActionToLikes < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :action, :boolean, default: false, null: false
  end
end
