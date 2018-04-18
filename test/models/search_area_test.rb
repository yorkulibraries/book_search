require 'test_helper'

class SearchAreaTest < ActiveSupport::TestCase

  should "create a valid SearchArea" do
    assert_difference "SearchArea.count", 1 do
      sa = build(:search_area)
      sa.save
    end
  end

  should "not create an invalid SearchArea" do
    assert ! build(:search_area, name: nil).valid?, "Name is required"
    assert ! build(:search_area, location: nil).valid?, "Location is required"
  end

  should "return primary or secondary search areas, based on scope" do
    create_list(:search_area, 3, primary: true)
    create_list(:search_area, 2, primary: false)

    assert_equal 3, SearchArea.primary.size
    assert_equal 2, SearchArea.secondary.size
  end
end
