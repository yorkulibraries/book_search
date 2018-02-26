require 'test_helper'

class PatronsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patron = patrons(:one)
  end

  test "should get index" do
    get patrons_url
    assert_response :success
  end

  test "should get new" do
    get new_patron_url
    assert_response :success
  end

  test "should create patron" do
    assert_difference('Patron.count') do
      post patrons_url, params: { patron: { email: @patron.email, login_id: @patron.login_id, name: @patron.name } }
    end

    assert_redirected_to patron_url(Patron.last)
  end

  test "should show patron" do
    get patron_url(@patron)
    assert_response :success
  end

  test "should get edit" do
    get edit_patron_url(@patron)
    assert_response :success
  end

  test "should update patron" do
    patch patron_url(@patron), params: { patron: { email: @patron.email, login_id: @patron.login_id, name: @patron.name } }
    assert_redirected_to patron_url(@patron)
  end

  test "should destroy patron" do
    assert_difference('Patron.count', -1) do
      delete patron_url(@patron)
    end

    assert_redirected_to patrons_url
  end
end
