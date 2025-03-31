require "test_helper"

class BeverageTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beverage_types_index_url
    assert_response :success
  end
end
