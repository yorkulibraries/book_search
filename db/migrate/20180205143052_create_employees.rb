class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :role
      t.string :email
      t.string :login_id
      t.integer :location_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
