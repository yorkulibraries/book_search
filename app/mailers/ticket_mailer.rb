class TicketMailer < ApplicationMailer
  default from: "book_search@test.yorku.ca"

  def new_ticket(ticket)
    
    @ticket = ticket
    @patron = ticket.patron

    @to = ticket.patron.email
    subject = "New Search Ticket Created"
    mail(to: @to, from: default_params[:from], subject: subject)
  end
end
