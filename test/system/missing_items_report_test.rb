require "application_system_test_case"

class MissingItemsReportTest < ApplicationSystemTestCase
    
  test "load the index page" do
    visit missing_items_report_index_path
    assert_selector "h1", text: "List of Missing Items: Report"
  end
  
end
