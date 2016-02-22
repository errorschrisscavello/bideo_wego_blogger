class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.text :body
      t.string :data_fileable_type
      t.integer :data_fileable_id
      t.integer :file_type_id

      t.index :data_fileable_type
      t.index :data_fileable_id
      t.index [:data_fileable_id, :data_fileable_type], :unique => true
      t.index :file_type_id

      t.timestamps null: false
    end
  end
end
