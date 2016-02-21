class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :uid, :null => false
      t.string :title, :null => false
      t.integer :parent_id
      t.integer :view_id
      t.integer :slug_id

      t.index :uid, :unique => true
      t.index :title, :unique => true
      t.index :parent_id
      t.index :view_id, :unique => true
      t.index :slug_id, :unique => true

      t.timestamps null: false
    end
  end
end
