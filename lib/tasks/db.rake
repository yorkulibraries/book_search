require 'faker'
require 'populator'

namespace :db do
  desc "Prepopulate Some Data"
  task populate: :environment do

    # CLEAR THE DATABASE FIRST
    [SearchTicket, Patron, Employee, Location, SearchArea, SearchTicket::WorkLog, SearchTicket::SearchedArea].each(&:delete_all)

    Location.populate(2..5) do |l|
      l.name = Faker::HarryPotter.location
      l.address = Faker::HarryPotter.house
      l.email = Faker::Internet.safe_email(l.name)
      l.phone = Faker::PhoneNumber.extension
      l.ils_code = ["SCOTT", "STEACIE", "FROST", "BRONFMAN"]

      SearchArea.populate(4..8) do |sa|
        sa.name = Faker::Job.field
        sa.location_id = l.id
        sa.primary = [true, false]
      end
    end

    location_ids = Location.ids
    roles = Employee::ROLES

    Employee.populate(roles.size) do |e|
      e.name = Faker::FamilyGuy.unique.character
      e.email = Faker::Internet.safe_email(e.name)
      e.role = roles.pop
      e.login_id = 8021..9021
      e.location_id = location_ids
      e.active = true
    end

    employee_ids = Employee.ids

    Patron.populate(100..200) do |patron|
      patron.name = Faker::GameOfThrones.character
      patron.email = Faker::Internet.safe_email(patron.name)
      patron.login_id = Faker::Number.unique.number(9)
    end
    patron_ids = Patron.ids


    SearchTicket::STATUSES.each do |status|

      SearchTicket.populate(5..10) do |report|
        # :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note
        report.location_id = location_ids
        letters = Faker::Lorem.word[0..1]
        report.item_callnumber = "#{letters} #{Faker::Number.number(3)} #{letters.first}#{Faker::Number.number(3)} #{Faker::Number.between(1957,2017)}".upcase

        report.item_title = Faker::Book.unique.title
        report.item_author = Faker::Book.unique.author
        report.item_issue = ["March", "Jan", "September", "Jun"]
        report.item_volume = ["v1", "v2", "vol 3"]
        report.item_year = 1998..2017
        report.item_id = 39007031170798..39009011170792
        report.item_location = Location.find(report.location_id).ils_code
        report.patron_id = patron_ids

        report.status = status
        report.note = Faker::WorldOfWarcraft.quote
        report.assigned_to_id = 0

        if status == SearchTicket::STATUS_SEARCH_IN_PROGRESS
          # only assign if status is search_in_progress
          report.assigned_to_id = employee_ids
        end


        if status == SearchTicket::STATUS_RESOLVED
          report.resolution = SearchTicket::RESOLUTIONS
        else
          report.resolution = SearchTicket::RESOLUTION_UNKNOWN
        end


      end


    end

    # Test Case for Patron Tickets. Ensure first patron in db has data
    patron_single = Patron.first

    SearchTicket.populate(8) do |ticket|
      ticket.location_id = location_ids
      ticket.item_title = Faker::Book.unique.title
      ticket.item_callnumber = "CD #{Faker::Code.unique.asin}"
      ticket.item_author = Faker::Book.unique.author
      ticket.item_id = rand(2900020030020..2900020040020)
      ticket.item_volume = "Vol 1"
      ticket.item_issue = "Issue 2"
      ticket.item_year = rand(1998..2017)
      ticket.patron_id = patron_single
      ticket.status = SearchTicket::STATUSES

      if status == SearchTicket::STATUS_SEARCH_IN_PROGRESS
        # only assign if status is search_in_progress
        report.assigned_to_id = employee_ids
      end

      if ticket.status == SearchTicket::STATUS_RESOLVED
        ticket.resolution = SearchTicket::RESOLUTIONS
      else
        ticket.resolution = SearchTicket::RESOLUTION_UNKNOWN
      end
    end



  end # End of Loop of Tables

end # End of Namespace db
