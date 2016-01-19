class AddUserTwitterAndPostDescription < ActiveRecord::Migration
  def change
    add_column :users, :twitter_handle, :string
    add_column :posts, :description, :string
  end
end
