class CreatePartials < ActiveRecord::Migration
  def change
    create_table :partials do |t|

      t.timestamps null: false
    end
  end
end
