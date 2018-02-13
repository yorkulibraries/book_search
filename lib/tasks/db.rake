require 'faker'
require 'populator'

namespace :db do
  desc "Prepopulate Some Data"
  task populate: :environment do

    # CLEAR THE DATABASE FIRST
    [MissingItemReport].each(&:delete_all)


    MissingItemReport.populate(100) do |report|
      # :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note
      report.item_callnumber = Faker::Bank.iban
      report.item_title = Faker::Book.title
      report.patron_id = 1..100
      report.location_id = 1..100
      report.resolution = MissingItemReport::RESOLUTIONS
      report.status = MissingItemReport::STATUSES
      report.note = Faker::WorldOfWarcraft.quote
    end

  end

end
