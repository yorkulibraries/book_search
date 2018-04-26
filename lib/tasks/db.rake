require 'faker'
require 'populator'

namespace :db do
  desc "Prepopulate Some Data"
  task populate: :environment do

    # CLEAR THE DATABASE FIRST
    [SearchTicket, Patron, Employee, Location, SearchArea, SearchTicket::WorkLog, SearchTicket::SearchedArea].each(&:delete_all)

    Employee.populate(5..10) do |e|
      e.name = Faker::FamilyGuy.unique.character
      e.email = Faker::Internet.safe_email(e.name)
      e.role = Employee::ROLES
      e.login_id = 8021..9021
      e.location_id = 1..100
      e.active = true
    end

    employee_ids = Employee.ids

    Location.populate(2..5) do |l|
      l.name = Faker::HarryPotter.location
      l.address = Faker::HarryPotter.house
      l.email = Faker::Internet.safe_email(l.name)
      l.phone = Faker::PhoneNumber.extension

      SearchArea.populate(4..8) do |sa|
        sa.name = Faker::Job.field
        sa.location_id = l.id
        sa.primary = [true, false]
      end
    end

    location_ids = Location.ids

    Patron.populate(100..200) do |patron|
      patron.name = Faker::GameOfThrones.character
      patron.email = Faker::Internet.safe_email(patron.name)
      patron.login_id = 9021..9999
    end
    patron_ids = Patron.ids


    SearchTicket::STATUSES.each do |status|

      SearchTicket.populate(5..10) do |report|
        # :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note
        report.item_callnumber = Faker::Code.unique.asin
        report.item_title = Faker::Book.unique.title
        report.item_id = 2900020030020..3910020030020
        report.patron_id = patron_ids
        report.location_id = location_ids

        report.status = status
        report.note = Faker::WorldOfWarcraft.quote

        if status == SearchTicket::STATUS_RESOLVED
          report.resolution = SearchTicket::RESOLUTIONS
          
        else
          report.resolution = SearchTicket::RESOLUTION_UNKNOWN
        end

        if status == SearchTicket::STATUS_NEW
          report.assigned_to_id = 0
        else
          report.assigned_to_id = employee_ids
        end

      end
    end


  end

end
