require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "John Doe", email: "test3@test.com",
      password: "12345678", password_confirmation: "12345678")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 93 + "test.com"
    assert_not @user.valid?
  end

  test "should reject invalid email" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end 
  end

  test "should reject duplicate email" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should downcase email before save" do
    @user.email = "TeSt3@test.com";
    @user.save
    assert @user.reload.email == "test3@test.com";
  end

  test "password should have minimum length of 8" do
    @user.password = @user.password_confirmation = "1234567"
    assert_not @user.valid?
  end

end
