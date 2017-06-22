require 'test_helper'

class ViewMyContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "view my contacts" do
    log_in_as(@user)
    get contacts_path
    assert_template 'contacts/index'
    assert @user.contacts
    assert_select "a.list-group-item", @user.contacts.count
    assert_difference 'Contact.count', -1 do
      delete contact_path(@user.contacts.first)
    end
  end

end
