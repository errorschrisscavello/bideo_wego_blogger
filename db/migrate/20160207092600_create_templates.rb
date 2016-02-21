class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.text :body
      t.string :templateable_type
      t.integer :templateable_id
      t.integer :file_type_id

      t.index :templateable_type
      t.index :templateable_id
      t.index [:templateable_id, :templateable_type], :unique => true
      t.index :file_type_id

      t.timestamps null: false
    end
  end
end
