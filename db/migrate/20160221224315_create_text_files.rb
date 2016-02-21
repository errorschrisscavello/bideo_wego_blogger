class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.text :body
      t.string :text_fileable_type
      t.integer :text_fileable_id
      t.integer :file_type_id

      t.index :text_fileable_type
      t.index :text_fileable_id
      t.index [:text_fileable_id, :text_fileable_type], :unique => true
      t.index :file_type_id

      t.timestamps null: false
    end
  end
end
