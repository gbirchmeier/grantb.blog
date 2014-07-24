class CreatePostTag < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.references :post, index: true, null: false
      t.references :tag, index: true, null: false
    end

    create_table :tags do |t|
      t.string :name, null: false, index: true
    end
  end
end
