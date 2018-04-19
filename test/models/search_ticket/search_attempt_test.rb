require 'test_helper'

class SearchTicket::SearchAttemptTest < ActiveSupport::TestCase
  should "create a valid SearchAttempt" do
    assert_difference "SearchTicket::SearchAttempt.count", 1 do
      sa = build(:search_attempt)
      sa.save
    end
  end

  should "not create an invalid SearchAttempt" do
    assert ! build(:search_attempt, search_ticket_id: nil).valid?, "Item ID is required"
    assert ! build(:search_attempt, employee: nil).valid?, "Employee is required"

  end

  should "set resolution on create to default values" do
    sa = build(:search_attempt)
    sa.save
    assert_equal SearchTicket::SearchAttempt::RESOLUTION_UNKNOWN, sa.resolution
  end
end