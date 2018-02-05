require "application_system_test_case"

class MissingItemsReportTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit missing_items_report_index_url
  #
  #   assert_selector "h1", text: "MissingItemsReport"
  # end
  
  test "load the index page" do
    # visit root_url
    get root_url
    # visit missing_items_report_index_path
    # assert_selector "h1", text: "List of Missing Items: Report"
    assert_selector "h1", text: "Dashboard"
  end
  
end
