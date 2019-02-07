json.extract! search_ticket, :id, :patron_id, :location_id, :item_id, :item_callnumber, :item_title, :item_author, :item_volume, :item_issue, :item_year, :item_location, :note, :resolution, :status, :assigned_to_id, :created_at, :updated_at
json.url admin_search_ticket_url(search_ticket, format: :json)
