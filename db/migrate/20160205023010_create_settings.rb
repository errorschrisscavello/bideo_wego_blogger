class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key, :null => false
      t.string :value
      t.integer :setting_type_id, :null => false

      t.index :key
      t.index :value
      t.index :setting_type_id
      t.index [:setting_type_id, :key], :unique => true

      t.timestamps null: false
    end
  end
end
