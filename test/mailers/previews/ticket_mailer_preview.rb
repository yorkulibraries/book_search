# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview

  def new_ticket_email

    ticket = SearchTicket.new
    ticket.patron = Patron.new(email: "test@test.com", name: "NAme")
    ticket.item_title = "Test Item Title"
    TicketMailer.new_ticket(ticket).deliver_now
  end
end
