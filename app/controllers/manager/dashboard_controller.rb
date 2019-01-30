class Manager::DashboardController < Manager::AuthorizedBaseController
  def show

    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    yesterday = Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day
    @created_today = SearchTicket.where(created_at: today).count
    @resolved_today = SearchTicket.resolved_tickets.where(updated_at: today).count

    @created_yesterday = SearchTicket.where(created_at: yesterday).count
    @resolved_yesterday = SearchTicket.resolved_tickets.where(updated_at: yesterday).count

    @created_past_7_days = SearchTicket.created_past_7_days.count

    @resolved_past_7_days = SearchTicket.resolved_tickets.updated_past_7_days.count

  end
end
