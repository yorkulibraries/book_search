require 'test_helper'

class SearchAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @search_area = search_areas(:one)
    @search_area = create(:search_area)
  end

  test "should get index" do
    get search_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_search_area_url
    assert_response :success
  end

  test "should create search_area" do
    assert_difference('SearchArea.count') do
      post search_areas_url, params: { search_area: { location_id: @search_area.location_id, name: @search_area.name, primary: @search_area.primary } }
    end

    assert_redirected_to search_area_url(SearchArea.last)
  end

  test "should show search_area" do
    get search_area_url(@search_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_search_area_url(@search_area)
    assert_response :success
  end

  test "should update search_area" do
    patch search_area_url(@search_area), params: { search_area: { location_id: @search_area.location_id, name: @search_area.name, primary: @search_area.primary } }
    assert_redirected_to search_area_url(@search_area)
  end

  test "should destroy search_area" do
    assert_difference('SearchArea.count', -1) do
      delete search_area_url(@search_area)
    end

    assert_redirected_to search_areas_url
  end
end
