require "test_helper"

class AccountNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_notifications_index_url
    assert_response :success
  end
end
