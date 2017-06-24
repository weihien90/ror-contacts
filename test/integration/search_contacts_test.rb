require 'test_helper'

class SearchContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @contact = @user.contacts.first
  end

  test "search my contacts" do
    log_in_as(@user)
    get search_contacts_path(keyword: @contact.email)
    assert_template 'contacts/search'
    assert_select "a.list-group-item", 1
  end

  test "search other user's contact" do
    log_in_as(@user)
    other_contact = users(:two).contacts.first
    get search_contacts_path(keyword: other_contact.email)
    assert_select "a.list-group-item", 0
  end

end
