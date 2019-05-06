require 'test_helper'

class SearchTicketTest < ActiveSupport::TestCase
  should "send a new ticket email when new ticket is created" do

    assert_enqueued_emails 1 do
      ticket = build(:search_ticket)
      ticket.save
    end

  end

  should "send a status resulved email of ticket status has changed" do
    ticket = create(:search_ticket)
    ticket.status = SearchTicket::STATUS_RESOLVED

    assert_enqueued_emails 1 do
      ticket.save
    end
  end

  should "not send email if status was not changed to resolved" do
    ticket = create(:search_ticket)
    ticket.status = SearchTicket::STATUS_SEARCH_IN_PROGRESS

    assert_enqueued_emails 0 do
      ticket.save
    end
  end
end
