require 'test_helper'

class TicketMailerTest < ActionMailer::TestCase
  should "send new ticket mail with the right stuff" do
    ticket = SearchTicket.new
    ticket.patron = Patron.new(email: "test@test.com", name: "NAme")
    ticket.item_title = "Test Item Title"
    ticket.status = SearchTicket::STATUS_NEW
    ticket.resolution = SearchTicket::RESOLUTION_UNKNOWN

    mail = TicketMailer.new_ticket(ticket).deliver_now
    assert !ActionMailer::Base.deliveries.empty?, "Shouldn't be empty"

    assert_not_nil mail.instance_variable_defined?("@ticket")
    assert_not_nil mail.instance_variable_defined?("@patron")
    assert_not_nil mail.instance_variable_defined?("@patron_name")
    assert_not_nil mail.instance_variable_defined?("@date")
    assert_not_nil mail.instance_variable_defined?("@short_date")
    assert_not_nil mail.instance_variable_defined?("@status")
    assert_not_nil mail.instance_variable_defined?("@resolution")
    assert_not_nil mail.instance_variable_defined?("@app_url")


    assert mail.to.first == ticket.patron.email
    assert_equal mail.subject, Setting.email_new_ticket_subject

  end

  should "send resoloved ticket mail with the right stuff" do
    ticket = SearchTicket.new
    ticket.patron = Patron.new(email: "test@test.com", name: "NAme")
    ticket.item_title = "Test Item Title"
    ticket.status = SearchTicket::STATUS_RESOLVED
    ticket.resolution = SearchTicket::RESOLUTION_FOUND

    mail = TicketMailer.ticket_resolved(ticket).deliver_now
    assert !ActionMailer::Base.deliveries.empty?, "Shouldn't be empty"

    assert_not_nil mail.instance_variable_defined?("@ticket")
    assert_not_nil mail.instance_variable_defined?("@patron")
    assert_not_nil mail.instance_variable_defined?("@patron_name")
    assert_not_nil mail.instance_variable_defined?("@date")
    assert_not_nil mail.instance_variable_defined?("@short_date")
    assert_not_nil mail.instance_variable_defined?("@status")
    assert_not_nil mail.instance_variable_defined?("@resolution")
    assert_not_nil mail.instance_variable_defined?("@app_url")


    assert mail.to.first == ticket.patron.email
    assert_equal mail.subject, Setting.email_ticket_resolved_subject

  end

  should "send an update to patron about the ticket" do
    ticket = SearchTicket.new
    ticket.patron = Patron.new(email: "test@test.com", name: "NAme")
    ticket.item_title = "Test Item Title"
    ticket.status = SearchTicket::STATUS_RESOLVED
    ticket.resolution = SearchTicket::RESOLUTION_FOUND

    update_message = "Something went terribly wrong and the book is missing. Sorry"

    mail = TicketMailer.patron_update(ticket, update_message).deliver_now
    assert !ActionMailer::Base.deliveries.empty?, "Shouldn't be empty"

    assert_not_nil mail.instance_variable_defined?("@ticket")
    assert_not_nil mail.instance_variable_defined?("@patron")
    assert_not_nil mail.instance_variable_defined?("@patron_name")
    assert_not_nil mail.instance_variable_defined?("@date")
    assert_not_nil mail.instance_variable_defined?("@short_date")
    assert_not_nil mail.instance_variable_defined?("@status")
    assert_not_nil mail.instance_variable_defined?("@resolution")
    assert_not_nil mail.instance_variable_defined?("@app_url")
    assert_not_nil mail.instance_variable_defined?("@message_to_patron")


    assert mail.to.first == ticket.patron.email
    assert_equal mail.subject, Setting.email_ticket_patron_update_subject

  end
end
