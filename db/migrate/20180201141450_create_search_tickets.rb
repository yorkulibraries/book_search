class CreateSearchTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :search_tickets do |t|

      t.integer :patron_id
      t.integer :location_id
      t.integer :item_id
      t.string :item_callnumber
      t.string :item_title
      t.text :note
      t.string :resolution
      t.string :status
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
