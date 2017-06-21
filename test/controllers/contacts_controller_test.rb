require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should get add contact page" do
    log_in_as(@user)
    get new_contact_path
    assert_response :success
  end

end
