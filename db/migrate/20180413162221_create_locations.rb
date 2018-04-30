class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :ils_code

      t.timestamps
    end
  end
end
