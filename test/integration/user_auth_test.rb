require "test_helper"

# US #9: As a User, I want to create my account so that I can have my own credentials
# US #10: As a User, I want to login my account so that I can access my account and link my own tasks.

class UserAuthTest < ActionDispatch::IntegrationTest
  test "should create account" do
    get new_user_registration_path
    assert_response :success

    # create user
    post user_registration_path, params: {
      user: {
        email: "test@mail.com",
        password: "123456",
        password_confirmation: "123456"
      } 
    }
    assert :redirect
    follow_redirect!
    assert_response :success
  end
end
