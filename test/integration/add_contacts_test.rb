require 'test_helper'

class AddContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "invalid contact information" do
    log_in_as(@user)
    get new_contact_path
    assert_no_difference 'Contact.count' do
      post contacts_path, params: {
        contact: { 
          name: "",
          email: "abc@invalid"
        }
      }
    end
    assert_template 'contacts/new'
    assert_select 'div.field_with_errors'
  end

  test "successfully added contact" do
    log_in_as(@user)
    get new_contact_path
    assert_difference 'Contact.count',1 do 
      post contacts_path, params: { 
        contact: {
          name: "Tom Cruise",
          email: "tomcruise@test.com"
        } 
      }
    end
    follow_redirect!
    assert_template 'contacts/index'
    assert_not flash.empty?
  end

end
