class CreateSearchAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :search_ticket_search_attempts do |t|      
      t.integer :search_ticket_id
      t.integer :employee_id
      t.string :resolution
      t.string :found_location
      t.text :note

      t.timestamps
    end
  end
end
