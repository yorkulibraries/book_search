class Coordinator::DashboardController < Coordinator::AuthorizedBaseController
  def show
    @under_review_tickets = current_user.location.tickets.under_review_tickets.recently_updated_first

    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    yesterday = Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day
    @created_today = current_user.location.tickets.where(created_at: today).count
    @resolved_today = current_user.location.tickets.resolved_tickets.where(updated_at: today).count

    @created_yesterday = current_user.location.tickets.where(created_at: yesterday).count
    @resolved_yesterday = current_user.location.tickets.resolved_tickets.where(updated_at: yesterday).count

    @created_past_7_days = current_user.location.tickets.created_past_7_days.count  

    @resolved_past_7_days = current_user.location.tickets.resolved_tickets.updated_past_7_days.count
  end
end
