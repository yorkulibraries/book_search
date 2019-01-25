class AddDefaultLocationToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :default_location, :boolean, default: false
  end
end
