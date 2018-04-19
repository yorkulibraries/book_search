class CreateSearchRequestSearchedAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :search_request_searched_areas do |t|
      t.integer :search_area_id
      t.integer :search_attempt_id
      t.integer :search_request_id

      t.timestamps
    end
  end
end
