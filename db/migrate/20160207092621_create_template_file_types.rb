class CreateTemplateFileTypes < ActiveRecord::Migration
  def change
    create_table :template_file_types do |t|

      t.timestamps null: false
    end
  end
end
