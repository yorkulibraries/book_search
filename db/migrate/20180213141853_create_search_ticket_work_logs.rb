class CreateSearchTicketWorkLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :search_ticket_work_logs do |t|
      t.integer :search_ticket_id
      t.integer :employee_id
      t.string :result
      t.string :found_location
      t.text :note
      t.string :work_type
      t.timestamps
    end
  end
end
