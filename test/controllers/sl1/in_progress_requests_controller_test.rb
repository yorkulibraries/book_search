require 'test_helper'

class Sl1::InProgressRequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show in progress search requests" do
    in_progress_requests = create_list(:search_request, 2, status: SearchRequest::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_requests = create_list(:search_request, 3, status: SearchRequest::STATUS_RESOLVED, assigned_to: @user)

    get sl1_in_progress_requests_path
    assert_response :success

    assert_select ".search_request_status", { count: in_progress_requests.size, text: SearchRequest::STATUS_SEARCH_IN_PROGRESS}
    assert_select ".search_request_status", { count: 0, text: SearchRequest::STATUS_RESOLVED }
  end


end
