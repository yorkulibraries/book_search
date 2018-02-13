require 'test_helper'

class MissingItemReportTest < ActiveSupport::TestCase
  
  ## RELATIONSHIPS
  should belong_to(:patron)
  
  ## VALIDATIONS
  should validate_presence_of(:item_id)
  should validate_presence_of(:patron_id)
  should validate_uniqueness_of(:item_id)
  
  should "create a valid MissingItemReport" do
    assert_difference "MissingItemReport.count", 1 do
      report = build(:missing_item_report)
      report.save
    end
  end

  should "not create an invalid MissingItemReport" do
    assert ! build(:missing_item_report, item_id: nil).valid?, "Item ID is required"
    assert ! build(:missing_item_report, patron: nil).valid?, "Patron ID is required"


    report = create(:missing_item_report)
    assert ! build(:missing_item_report, item_id: report.item_id).valid?, "Should be invalid since report with item is created already"
  end

  should "set status and resolution on create to default values" do
    report = build(:missing_item_report)
    report.save
    assert_equal MissingItemReport::STATUS_OPEN, report.status
    assert_equal MissingItemReport::RESOLUTION_UNKNOWN, report.resolution
  end

end
