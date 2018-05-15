class CreateSearchTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :search_tickets do |t|

      t.integer :patron_id
      t.integer :location_id
      t.string :item_id
      t.string :item_callnumber
      t.string :item_title
      t.string :item_author
      t.string :item_volume
      t.string :item_issue
      t.string :item_year
      t.string :item_location
      t.text :note
      t.string :resolution
      t.string :status
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
