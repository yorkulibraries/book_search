require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should "create a valid Location" do
    assert_difference "Location.count", 1 do
      l = build(:location)
      l.save
    end
  end

  should "not create an invalid patron" do
    assert ! build(:location, email: nil).valid?, "Email Address is required"
    assert ! build(:location, name: nil).valid?, "Name is required"
  end

  should "show tickets in this location" do
    l = create(:location)
    location_tickets = create_list(:search_ticket, 3, location: l)
    other_tickets = create_list(:search_ticket, 2)

    assert_equal location_tickets.size, l.tickets.size
  end
end
