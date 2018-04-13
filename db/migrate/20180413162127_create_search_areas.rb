class CreateSearchAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :search_areas do |t|
      t.string :name
      t.integer :location_id
      t.boolean :primary, default: true

      t.timestamps
    end
  end
end
