class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.string :name, :null => false
      t.integer :template_id

      t.index :name, :unique => true
      t.index :template_id

      t.timestamps null: false
    end
  end
end
