require "test_helper"

class SymptomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get symptoms_index_url
    assert_response :success
  end
end
