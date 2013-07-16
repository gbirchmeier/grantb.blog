class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null=>false
      t.string :email, :null=>false
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :auth_token
    end

    add_index :users, :username, :unique=>true
    add_index :users, :email
  end
end

