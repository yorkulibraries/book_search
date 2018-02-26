json.extract! patron, :id, :name, :email, :login_id, :created_at, :updated_at
json.url patron_url(patron, format: :json)
