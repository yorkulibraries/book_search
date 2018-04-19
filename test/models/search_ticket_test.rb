require 'test_helper'

class SearchTicketTest < ActiveSupport::TestCase
  should "create a valid SearchTicket" do
    assert_difference "SearchTicket.count", 1 do
      report = build(:search_ticket)
      report.save
    end
  end

  should "not create an invalid SearchTicket" do
    assert ! build(:search_ticket, item_id: nil).valid?, "Item ID is required"
    assert ! build(:search_ticket, patron: nil).valid?, "Patron ID is required"


    report = create(:search_ticket)
    # assert ! build(:search_ticket, item_id: report.item_id).valid?, "Should be invalid since report with item is created already"
  end

  should "set status and resolution on create to default values" do
    report = build(:search_ticket)
    report.save
    assert_equal SearchTicket::STATUS_NEW, report.status
    assert_equal SearchTicket::RESOLUTION_UNKNOWN, report.resolution
  end

  should "show new tickets only" do
    create(:search_ticket, status: SearchTicket::STATUS_NEW)
    create(:search_ticket, status: SearchTicket::STATUS_RESOLVED)

    assert_equal 1, SearchTicket.new_tickets.size, "Should just be one"
  end

  should "show new tickets only" do
    create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    create(:search_ticket, status: SearchTicket::STATUS_RESOLVED)

    assert_equal 1, SearchTicket.in_progress_tickets.size, "Should just be one"
  end


end
