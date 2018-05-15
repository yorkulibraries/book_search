require 'test_helper'

class Patron::RequestSearchControllerTest < ActionDispatch::IntegrationTest

  setup do
    #@user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    #log_user_in(@user)
    @ticket_params = attributes_for(:search_ticket).slice(
        :item_title, :item_callnumber, :item_author, :item_id, :item_volume, :item_issue, :item_year)
    @patron_params = attributes_for(:patron).slice(:name, :email, :login_id)
    @location = create(:location)
  end

  should "show new search ticket page with details and form for patron information" do

    get new_patron_request_search_path, params: { search_ticket: @ticket_params, patron: @patron_params, location: @location.ils_code }
    assert_response :success

    # ensure all the fields are present in the form
    assert_select '#search_ticket_patron_email[value=?]', @patron_params[:email]
    assert_select '#search_ticket_patron_name[value=?]', @patron_params[:name]
    assert_select '#search_ticket_patron_id', { value: Patron.last.id }

    assert_select '#search_ticket_item_title', { value: @ticket_params[:item_title] }
    assert_select '#search_ticket_item_callnumber', { value: @ticket_params[:item_callnumber] }
    assert_select "#search_ticket_item_id", { value: @ticket_params[:item_id] }
    assert_select '#search_ticket_item_volume', { value: @ticket_params[:item_volume] }
    assert_select '#search_ticket_item_year', { value: @ticket_params[:item_year] }
    assert_select '#search_ticket_item_issue', { value: @ticket_params[:item_issue] }
    assert_select '#search_ticket_item_author', { value: @ticket_params[:item_author] }
    assert_select '#search_ticket_location_id', { value: @location.id }

  end

  should "create a new patron if one doesn't exist" do
    assert_difference "Patron.count" do
      get new_patron_request_search_path, params: { search_ticket: @ticket_params, patron: @patron_params, location: @location.ils_code }
      assert_response :success
    end

    patron = Patron.last
    assert_equal patron.login_id, @patron_params[:login_id]
    assert_equal patron.name, @patron_params[:name]
    assert_equal patron.email, @patron_params[:email]
  end


  should "use an existing patron if it exists" do
    patron = create(:patron)
    patron_attrs = patron.slice(:name, :email, :login_id)

    assert_no_difference "Patron.count" do
      get new_patron_request_search_path, params: { search_ticket: @ticket_params, patron: patron_attrs, location: @location.ils_code }
      assert_response :success
    end

  end



  should "create a new search ticket. PATRON must be created already. Done in the new action" do
    patron = create(:patron)

    @ticket_params[:patron_attributes] = @patron_params
    @ticket_params[:location_id] = @location.id
    @ticket_params[:patron_id] = patron.id
    @ticket_params[:patron_attributes] = { id: patron.id }

    assert_difference "SearchTicket.count" do
      assert_no_difference "Patron.count" do
        post patron_request_search_index_path, params: { search_ticket: @ticket_params }

        assert_response :redirect
        assert_redirected_to patron_request_search_path(SearchTicket.last)
      end
    end
  end

end
