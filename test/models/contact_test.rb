require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact = @user.contacts.build(
      name: "Johnny Bravo",
      email: "johnnybravo@gmail.com"
    )
  end

  test "should be valid" do
    assert @contact.valid?
  end

  test  "created contact belongs to user" do
    @contact.save
    assert_equal @contact.user_id, @user.id
  end

  test "name should be present" do
    @contact.name = ""
    assert_not @contact.valid?
  end

  test "email should be present" do
    @contact.email = ""
    assert_not @contact.valid?
  end

  test "name should not be too long" do
    @contact.name = "a" * 51
    assert_not @contact.valid?
  end

  test "email should not be too long" do
    @contact.email = "a" * 93 + "test.com"
    assert_not @contact.valid?
  end

  test "should reject invalid birthday" do
    invalid_dates = %w[19999-04-04]
    invalid_dates.each do |invalid_date|
      @contact.birthday = invalid_date
      assert_not @contact.valid?, "#{invalid_date.inspect} should be invalid"
    end
  end

  test "should reject invalid email" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.]
    invalid_addresses.each do |invalid_address|
      @contact.email = invalid_address
      assert_not @contact.valid?, "#{invalid_address.inspect} should be invalid"
    end 
  end

  test "should reject same email by same user" do
    @contact.save
    duplicate_contact = @contact.dup
    assert_not duplicate_contact.valid?

    duplicate_contact.user_id = users(:two).id
    assert duplicate_contact.valid?
  end

  test "should downcase email before save" do
    @contact.email = "TeSt3@test.com";
    @contact.save
    assert @contact.reload.email == "test3@test.com";
  end 

  test "should exclude soft deleted by default" do
    assert_not_equal Contact.count, Contact.unscoped.count
  end

  test "should get archived post" do
    Contact.unscoped.archived.each do |contact|
      assert contact.deleted_at
    end
  end

end
