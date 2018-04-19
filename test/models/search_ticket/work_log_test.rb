require 'test_helper'

class SearchTicket::WorkLogTest < ActiveSupport::TestCase
  should "create a valid WorkLog" do
    assert_difference "SearchTicket::WorkLog.count", 1 do
      sa = build(:work_log)
      sa.save
    end
  end

  should "not create an invalid WorkLog" do
    assert ! build(:work_log, search_ticket_id: nil).valid?, "Item ID is required"
    assert ! build(:work_log, employee: nil).valid?, "Employee is required"

  end

  should "set resolution on create to default values" do
    sa = build(:work_log)
    sa.save
    assert_equal SearchTicket::WorkLog::RESULT_UNKNOWN, sa.resolution
  end
end
