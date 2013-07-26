class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :headline, :null=>false
      t.string :content, :null=>false
      t.date :published_at
      t.references :user, :null=>false
      t.timestamps
    end
  end
end
