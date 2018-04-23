require 'test_helper'

class SearchTicket::WorkLogTest < ActiveSupport::TestCase
  should "create a valid WorkLog" do
    assert_difference "SearchTicket::WorkLog.count", 1 do
      log = build(:work_log)      
      log.save
    end
  end

  should "not create an invalid WorkLog" do
    assert ! build(:work_log, search_ticket_id: nil).valid?, "Item ID is required"
    assert ! build(:work_log, employee: nil).valid?, "Employee is required"
    assert ! build(:work_log, work_type: nil).valid?, "Work Type is required"
    assert ! build(:work_log, result: nil).valid?, "Result is required"
    assert ! build(:work_log, result:  SearchTicket::WorkLog::RESULT_FOUND, found_location: nil).valid?, "Found location is required, if result is found"
  end

  should "set resolution on create to default values" do
    log = build(:work_log)
    log.save
    assert_equal SearchTicket::WorkLog::RESULT_UNKNOWN, log.result
  end

end
