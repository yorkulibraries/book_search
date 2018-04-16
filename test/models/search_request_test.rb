require 'test_helper'

class SearchRequestTest < ActiveSupport::TestCase
  should "create a valid SearchRequest" do
    assert_difference "SearchRequest.count", 1 do
      report = build(:search_request)
      report.save
    end
  end

  should "not create an invalid SearchRequest" do
    assert ! build(:search_request, item_id: nil).valid?, "Item ID is required"
    assert ! build(:search_request, patron: nil).valid?, "Patron ID is required"


    report = create(:search_request)
    # assert ! build(:search_request, item_id: report.item_id).valid?, "Should be invalid since report with item is created already"
  end

  should "set status and resolution on create to default values" do
    report = build(:search_request)
    report.save
    assert_equal SearchRequest::STATUS_NEW, report.status
    assert_equal SearchRequest::RESOLUTION_UNKNOWN, report.resolution
  end

  should "show new requests only" do
    create(:search_request, status: SearchRequest::STATUS_NEW)
    create(:search_request, status: SearchRequest::STATUS_RESOLVED)

    assert_equal 1, SearchRequest.new_requests.size, "Should just be one"
  end


end
