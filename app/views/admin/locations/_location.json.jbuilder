json.extract! location, :id, :name, :address, :email, :phone, :created_at, :updated_at
json.url admin_location_url(location, format: :json)
