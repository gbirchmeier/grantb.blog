class UniqueNiceUrl < ActiveRecord::Migration
  def change
    add_index :posts, :nice_url, :unique=>true
  end
end
