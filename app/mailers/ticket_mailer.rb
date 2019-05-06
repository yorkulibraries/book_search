class TicketMailer < ApplicationMailer
  default from: "book_search@test.yorku.ca"

  def new_ticket(ticket)
    @template = Liquid::Template.parse(Setting.email_new_ticket_body)  # Parses and compiles the template

    @ticket = ticket
    @patron = ticket.patron

    @date = Date.today.strftime("%b %e, %Y")
    @date_short = Date.today.strftime("%m-%d-%Y")
    @status = @ticket.status
    @app_url = root_url

    @to = ticket.patron.email
    subject = Setting[:email_new_ticket_subject]
    mail(to: @to, from: default_params[:from], subject: subject)
  end

  def ticket_resolved(ticket)
    @template = Liquid::Template.parse(Setting.email_ticket_resolved_body)  # Parses and compiles the template

    @ticket = ticket
    @patron = ticket.patron

    @date = Date.today.strftime("%b %e, %Y")
    @date_short = Date.today.strftime("%m-%d-%Y")
    @status = @ticket.status
    @app_url = root_url

    @to = ticket.patron.email
    subject = Setting[:email_ticket_resolved_subject]
    mail(to: @to, from: default_params[:from], subject: subject)
  end
end
