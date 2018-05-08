require 'test_helper'

class Admin::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @location = locations(:one)
    @location = create(:location)
  end

  test "should get index" do
    get admin_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_url
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post admin_locations_url, params: { location: { address: @location.address, email: @location.email, ils_code: @location.ils_code, name: @location.name, phone: @location.phone } }
    end

    assert_redirected_to admin_location_url(Location.last)
  end

  test "should show location" do
    get admin_location_url(@location)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_location_url(@location)
    assert_response :success
  end

  test "should update location" do
    patch admin_location_url(@location), params: { location: { address: @location.address, email: @location.email, name: @location.name, phone: @location.phone } }
    assert_redirected_to admin_location_url(@location)
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete admin_location_url(@location)
    end

    assert_redirected_to admin_locations_url
  end
end
