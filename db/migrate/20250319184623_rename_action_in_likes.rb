class RenameActionInLikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :action, :liked_action
  end
end
