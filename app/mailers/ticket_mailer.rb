class TicketMailer < ApplicationMailer
  default from: "book_search@test.yorku.ca"

  def new_ticket(ticket)
    @template = Liquid::Template.parse(Setting.email_new_ticket_body)  # Parses and compiles the template

    @ticket = ticket
    @patron = ticket.patron

    @date = Date.today.strftime("%b %e, %Y")
    @date_short = Date.today.strftime("%m-%d-%Y")
    @status = @ticket.ticket_status_description
    @resolution = @ticket.ticket_resolution_description
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
    @status = @ticket.ticket_status_description
    @resolution = @ticket.ticket_resolution_description
    @app_url = root_url

    @to = ticket.patron.email
    subject = Setting[:email_ticket_resolved_subject]
    mail(to: @to, from: default_params[:from], subject: subject)
  end

  def patron_update(ticket, worklog_note)
    @template = Liquid::Template.parse(Setting.email_ticket_patron_update_body)  # Parses and compiles the template

    @ticket = ticket
    @patron = ticket.patron

    @date = Date.today.strftime("%b %e, %Y")
    @date_short = Date.today.strftime("%m-%d-%Y")
    @status = @ticket.ticket_status_description
    @resolution = @ticket.ticket_resolution_description
    @app_url = root_url
    @message_to_patron = worklog_note

    @to = ticket.patron.email
    subject = Setting[:email_ticket_patron_update_subject]
    mail(to: @to, from: default_params[:from], subject: subject)
  end
end
