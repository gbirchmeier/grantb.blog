class AddMarkupTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :markup_type, :string, :null=>false, :default=>"markdown"
  end
end
