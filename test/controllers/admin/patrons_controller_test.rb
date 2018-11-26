require 'test_helper'

class Admin::PatronsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patron = create(:patron)
    @user = create(:employee, role: Employee::ROLE_COORDINATOR)
    log_user_in(@user)
  end

  test "should get index" do
    get admin_patrons_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_patron_url
    assert_response :success
  end

  test "should create patron" do
    assert_difference('Patron.count') do
      post admin_patrons_url, params: { patron: attributes_for(:patron) } #{ email: @patron.email, login_id: @patron.login_id, name: @patron.name } }
    end

    assert_redirected_to admin_patron_url(Patron.last)
  end

  test "should show patron" do
    get admin_patron_url(@patron)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_patron_url(@patron)
    assert_response :success
  end

  test "should update patron" do
    patch admin_patron_url(@patron), params: { patron: { email: @patron.email, login_id: @patron.login_id, name: @patron.name } }
    assert_redirected_to admin_patron_url(@patron)
  end

  test "should destroy patron" do
    assert_difference('Patron.count', -1) do
      delete admin_patron_url(@patron)
    end

    assert_redirected_to admin_patrons_url
  end
end
