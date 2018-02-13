class CreateSearchAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :search_attempts do |t|      
      t.integer :missing_item_report_id
      t.integer :employee_id
      t.string :resolution
      t.string :found_location
      t.text :note

      t.timestamps
    end
  end
end
