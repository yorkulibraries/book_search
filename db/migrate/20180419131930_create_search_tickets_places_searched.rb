class CreateSearchTicketSearchedAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :search_ticket_searched_areas do |t|
      t.integer :search_area_id
      t.integer :search_attempt_id
      t.integer :search_ticket_id

      t.timestamps
    end
  end
end
