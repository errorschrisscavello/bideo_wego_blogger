class CreateSlugs < ActiveRecord::Migration
  def change
    create_table :slugs do |t|
      t.string :uri
      t.string :sluggable_type
      t.integer :sluggable_id

      t.index :uri, :unique => true
      t.index :sluggable_type
      t.index :sluggable_id
      t.index [:sluggable_id, :sluggable_type], :unique => true

      t.timestamps null: false
    end
  end
end
