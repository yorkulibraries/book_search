require 'test_helper'

class SearchAttemptTest < ActiveSupport::TestCase
  should "create a valid SearchAttempt" do
    assert_difference "SearchAttempt.count", 1 do
      sa = build(:search_attempt)
      sa.save
    end
  end

  should "not create an invalid SearchAttempt" do
    assert ! build(:search_attempt, missing_item_report_id: nil).valid?, "Item ID is required"
    assert ! build(:search_attempt, employee: nil).valid?, "Employee is required"

  end

  should "set resolution on create to default values" do
    sa = build(:search_attempt)
    sa.save
    assert_equal SearchAttempt::RESOLUTION_UNKNOWN, sa.resolution
  end
end