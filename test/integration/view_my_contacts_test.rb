require 'test_helper'

class ViewMyContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "view my contacts" do
    log_in_as(@user)
    get contacts_path
    assert @user.contacts
    assert_select "a.list-group-item", @user.contacts.count
    assert_template 'contacts/index'
  end

end
