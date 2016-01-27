class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :username
      t.string :password_digest
      t.string :auth_token

      t.index :email, :unique => true
      t.index :username, :unique => true
      t.index :auth_token, :unique => true

      t.timestamps null: false
    end
  end
end
