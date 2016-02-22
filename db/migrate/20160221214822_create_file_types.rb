class CreateFileTypes < ActiveRecord::Migration
  def change
    create_table :file_types do |t|
      t.string :name, :null => false
      t.string :extension, :null => false

      t.index :name, :unique => true
      t.index :extension, :unique => true

      t.timestamps null: false
    end
  end
end
