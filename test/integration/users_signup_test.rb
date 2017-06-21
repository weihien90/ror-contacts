require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { 
        user: {
          name: "",
          email: "test@invalid",
          password: "foo",
          password_confirmation: "bar"
        } 
      }
    end
    assert_template 'users/new'
    assert_select 'div.field_with_errors'
  end

  test "successful signup" do
    get signup_path
    assert_difference 'User.count',1 do 
      post users_path, params: { 
        user: {
          name: "John Doe",
          email: "johndoe@test.com",
          password: "12345678",
          password_confirmation: "12345678"
        } 
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
