require "test_helper"

class BeverageEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get beverage_entries_new_url
    assert_response :success
  end

  test "should get create" do
    get beverage_entries_create_url
    assert_response :success
  end

  test "should get show" do
    get beverage_entries_show_url
    assert_response :success
  end

  test "should get index" do
    get beverage_entries_index_url
    assert_response :success
  end
end
