require 'test_helper'

class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get authentications_home_url
    assert_response :success
  end

end
