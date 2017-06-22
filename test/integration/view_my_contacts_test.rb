require 'test_helper'

class ViewMyContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @contact = @user.contacts.first
  end

  test "view my contacts" do
    log_in_as(@user)
    get contacts_path
    assert_template 'contacts/index'
    assert_select "a.list-group-item", @user.contacts.count
    assert_difference 'Contact.count', -1 do
      delete contact_path(@contact)
    end
    assert_not_nil Contact.unscoped.find(@contact.id).deleted_at
  end

end
