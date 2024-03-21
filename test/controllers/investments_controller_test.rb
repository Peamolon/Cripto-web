require "test_helper"

class InvestmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get investments_new_url
    assert_response :success
  end
end
