require 'faker'
require 'populator'

namespace :db do
  desc "Prepopulate Some Data"
  task populate: :environment do

    # CLEAR THE DATABASE FIRST
    [SearchTicket, Patron, Employee, Location, SearchArea].each(&:delete_all)

    Employee.populate(20..40) do |e|
      e.name = Faker::WorldOfWarcraft.hero
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
        sa.name = Faker::Dune.planet
        sa.location_id = l.id
        sa.primary = [true, false]
      end
    end

    location_ids = Location.ids

    Patron.populate(100..200) do |patron|
      patron.name = Faker::GameOfThrones.character
      patron.email = Faker::Internet.safe_email(patron.name)
      patron.login_id = 9021..9999

      SearchTicket.populate(1..2) do |report|
        # :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note
        report.item_callnumber = Faker::Bank.iban
        report.item_title = Faker::Book.title
        report.item_id = 2900..3910
        report.patron_id = patron.id
        report.location_id = 1..100
        report.resolution = SearchTicket::RESOLUTIONS
        report.status = SearchTicket::STATUSES
        report.note = Faker::WorldOfWarcraft.quote

        report.assigned_to_id = employee_ids.push(0)
      end
    end

  end

end
