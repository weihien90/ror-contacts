require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @contact = contacts(:one)
  end

  test "should get new page" do
    log_in_as(@user)
    get new_contact_path
    assert_response :success
  end

  test "should get index page" do
    log_in_as(@user)
    get contacts_path
    assert_response :success
  end

  test "should get archived page" do
    log_in_as(@user)
    get archived_contacts_path
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

  test "should redirect index when not logged in" do
    get contacts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect archived when not logged in" do
    get archived_contacts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete contact_path(@contact)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect restore when not logged in" do
    patch restore_contact_path(@contact)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect download_vcard when not logged in" do
    get download_vcard_contact_path(@contact)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy if contact not belongs to user" do
    log_in_as(@user)
    other_contact = contacts(:three)
    assert_not_equal other_contact.user_id, @user.id
    assert_no_difference 'Contact.count' do
      delete contact_path(other_contact)
    end
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect restore if contact not belongs to user" do
    log_in_as(@user)
    other_contact = contacts(:three)
    assert_not_equal other_contact.user_id, @user.id
    assert_no_difference 'Contact.count' do
      patch restore_contact_path(other_contact)
    end
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect download_vcard if contact not belongs to user" do
    log_in_as(@user)
    other_contact = contacts(:three)
    assert_not_equal other_contact.user_id, @user.id
    get download_vcard_contact_path(other_contact)
    assert flash.empty?
    assert_redirected_to root_url
  end
end
