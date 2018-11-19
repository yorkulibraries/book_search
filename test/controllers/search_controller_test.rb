require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest

  context "as coordinator and other roles" do
    setup do
      @employee = create(:employee, role: Employee::ROLE_COORDINATOR)
      log_user_in(@employee)
    end


    should "search by id" do
      t  = create(:search_ticket)
      t1 = create(:search_ticket)

      get search_url, params: { q: t.id }
      assert_response :success

      assert_select "[data-search-results]", { value: 1 }, "Should be one search result"
    end

    should "display no results if nothing is found" do
      get search_url, params: { q: 55 }
      assert_response :success
      assert_select "[data-search-results]", { value: 0 }, "Should be no results"
    end

    should "search by item_id" do
      t = create(:search_ticket)
      t2 = create(:search_ticket)

      get search_url, params: { q: t.item_id}
      assert_response :success
      assert_select "[data-search-results]", { value: 1}, "Should be one result"
    end

    should 'Not freak out if by chance ID and ITEM_ID are the same' do
      t = create(:search_ticket)
      t.item_id = t.id
      t.save

      get search_url, params: { q: t.id }
      assert_response :success
      assert_select "[data-search-results]", { value: 1}, "should still return one"
    end
  end



  context "Specifying role in the test " do

    setup do
      @ticket = create(:search_ticket)
    end

    should 'redirect to the proper location FOR SL1' do
      employee = create(:employee, role: Employee::ROLE_LEVEL_ONE)
      log_user_in(employee)

      get search_result_url(@ticket)
      assert_redirected_to sl1_search_ticket_url(@ticket)
    end

    should 'redirect to the proper location FOR SL2' do
      employee = create(:employee, role: Employee::ROLE_LEVEL_TWO)
      log_user_in(employee)

      get search_result_url(@ticket)
      assert_redirected_to sl2_search_ticket_url(@ticket)
    end

    should 'redirect to the proper location FOR COORDINATOR and MANAGER' do
      employee = create(:employee, role: Employee::ROLE_COORDINATOR)
      log_user_in(employee)

      get search_result_url(@ticket)
      assert_redirected_to coordinator_search_ticket_url(@ticket)

      employee = create(:employee, role: Employee::ROLE_MANAGER)
      log_user_in(employee)

      get search_result_url(@ticket)
      assert_redirected_to coordinator_search_ticket_url(@ticket)
    end

  end

end
