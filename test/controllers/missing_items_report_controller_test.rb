require 'test_helper'

class MissingItemsReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get missing_items_report_index_url
    assert_response :success
  end

end
