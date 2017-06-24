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
    assert_select "a[data-confirm]", @user.contacts.count
  end

  test "view archived contacts" do
    log_in_as(@user)
    get archived_contacts_path
    assert_template 'contacts/archived'
    archived_contacts = Contact.unscoped.archived.where(user: @user)
    assert_select "a.list-group-item", archived_contacts.count
    assert_select "a[data-method='patch']", archived_contacts.count
  end

  test "archive and restore contact" do
    log_in_as(@user)
    get contacts_path
    assert_difference 'Contact.count', -1 do
      delete contact_path(@contact)
    end
    assert_not_nil Contact.unscoped.find(@contact.id).deleted_at

    get archived_contacts_path
    assert_difference 'Contact.count', +1 do
      patch restore_contact_path(@contact)
    end
    assert_nil Contact.unscoped.find(@contact.id).deleted_at
  end

  test "download VCard of contact" do
    log_in_as(@user)
    get download_vcard_contact_path(@contact, format: :vcf)
    assert_response :success
    assert_equal "text/x-vcard", response.content_type
  end

end
