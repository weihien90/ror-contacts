require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @contact = contacts(:one)
  end

  test "should get add contact page" do
    log_in_as(@user)
    get new_contact_path
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_contact_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    post contacts_path, params: { contact: { name: @contact.name, email: @contact.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
