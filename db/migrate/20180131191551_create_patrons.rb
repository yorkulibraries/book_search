class CreatePatrons < ActiveRecord::Migration[5.1]
  def change
    create_table :patrons do |t|
      t.string :name
      t.string :email
      t.string :login_id

      t.timestamps
    end
  end
end
