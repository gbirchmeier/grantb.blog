class AddNiceUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :nice_url, :string, unique: true
  end
end
