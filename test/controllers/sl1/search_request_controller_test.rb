require 'test_helper'

class Sl1::SearchRequestControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "display the details for a search request" do
    sr = create(:search_request)

    get sl1_search_request_path(sr)
    assert_response :success
    assert_select ".card-header", "Search Request Details"
  end

  should "display the search attempt form if request has no search attemps, only for STATUS_SEARCH_IN_PROGRESS requests" do
    sr = create(:search_request, status: SearchRequest::STATUS_SEARCH_IN_PROGRESS)

    get edit_sl1_search_request_path(sr)
    assert_response :success
    assert_select "h1", "Record Search Attempt"
  end

  should "add a new search attempt to the request, if none are present" do
    sr = create(:search_request, status: SearchRequest::STATUS_SEARCH_IN_PROGRESS)

    assert_equal 0, sr.search_attempts.size , "Precodition: No Search Attempts"
    assert_equal SearchRequest::STATUS_SEARCH_IN_PROGRESS, sr.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchAttempt.count", 1 do
      patch sl1_search_request_path(sr)
      assert_redirected_to sl1_search_request_path(sr)
    end

    sr.reload

    assert_equal 1, sr.search_attempts.size
    assert_equal SearchRequest::STATUS_SEARCH_IN_PROGRESS, sr.status, "Status shouldn't change"
  end


  should "redirect to details page for EDIT and UPDATE actions if search attempt has been recorded or search request status is not STATUS_SEARCH_IN_PROGRESS" do
    sr = create(:search_request, status: SearchRequest::STATUS_NEW)
    sa = create(:search_attempt, search_request: sr)

    get edit_sl1_search_request_path(sr)
    assert_redirected_to sl1_search_request_path

    patch sl1_search_request_path(sr)
    assert_redirected_to sl1_search_request_path

    sr = create(:search_request, status: SearchRequest::STATUS_RESOLVED)
    get edit_sl1_search_request_path(sr)
    assert_redirected_to sl1_search_request_path

    patch sl1_search_request_path(sr)
    assert_redirected_to sl1_search_request_path
  end
end
