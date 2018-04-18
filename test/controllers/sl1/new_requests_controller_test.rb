require 'test_helper'

class Sl1::NewRequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show new search requests" do
    new_requests = create_list(:search_request, 2, status: SearchRequest::STATUS_NEW)
    other_requests = create_list(:search_request, 3, status: SearchRequest::STATUS_RESOLVED)

    get sl1_new_requests_path
    assert_response :success

    assert_select ".search_request_status", { count: new_requests.size, text: SearchRequest::STATUS_NEW}
    assert_select ".search_request_status", { count: 0, text: SearchRequest::STATUS_RESOLVED }
  end

end
