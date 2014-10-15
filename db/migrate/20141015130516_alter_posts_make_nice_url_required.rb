class AlterPostsMakeNiceUrlRequired < ActiveRecord::Migration
  def up
    change_column :posts, :nice_url, :string, null: false
  end

  def down
    change_column :posts, :nice_url, :string, null: true
  end
end
