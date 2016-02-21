class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :viewable_type
      t.integer :viewable_id
      t.integer :template_layout_id
      t.integer :template_id

      t.index :viewable_id
      t.index :viewable_type
      t.index [:viewable_id, :viewable_type], :unique => true
      t.index :template_layout_id
      t.index :template_id

      t.timestamps null: false
    end
  end
end
