class ModifyUserNames < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :user_name, :string
  end
end
