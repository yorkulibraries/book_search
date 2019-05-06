module TicketNotifier
  extend ActiveSupport::Concern

  included do
    after_create -> { notify_patron_new_ticket }
    after_update -> { notify_patron_resolved_status }
  end


  def notify_patron_new_ticket
    TicketMailer.new_ticket(self).deliver_later
  end

  def notify_patron_resolved_status
    if self.saved_change_to_status? && self[:status] == SearchTicket::STATUS_RESOLVED
      TicketMailer.ticket_resolved(self).deliver_later
    end
  end

end
