require 'faker'
require 'populator'

namespace :db do
  desc "Prepopulate Some Data"
  task populate: :environment do

    # CLEAR THE DATABASE FIRST
    [MissingItemReport, Patron, Employee].each(&:delete_all)

    Employee.populate(20..40) do |e|
      e.name = Faker::WorldOfWarcraft.hero
      e.email = Faker::Internet.safe_email(e.name)
      e.role = Employee::ROLES
      e.login_id = 802101111..802102222
      e.location_id = 1..100
      e.active = true
    end

    employee_ids = Employee.ids

    Patron.populate(100..200) do |patron|
      patron.name = Faker::GameOfThrones.character
      patron.email = Faker::Internet.safe_email(patron.name)
      patron.login_id = 902101111..902102222

      MissingItemReport.populate(1..2) do |report|
        # :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note
        report.item_callnumber = Faker::Bank.iban
        report.item_title = Faker::Book.title
        report.item_id = 2900000000..2910000000
        report.patron_id = patron.id
        report.location_id = 1..100
        report.resolution = MissingItemReport::RESOLUTIONS
        report.status = MissingItemReport::STATUSES
        report.note = Faker::WorldOfWarcraft.quote

        report.assigned_to_id = employee_ids
      end
    end

  end

end
