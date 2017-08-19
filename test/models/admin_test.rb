require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test "respond_to attributes" do
    model = Admin.new
    assert_respond_to model, :login
    assert_respond_to model, :password_digest
    assert_respond_to model, :password
    assert_respond_to model, :remember_token
  end

  test "invalid login" do
    assert_not Admin.new(login: '', password: '123qwe').save, 'empty login'
  end
  test "invalid password" do
    assert_not Admin.new(login: 'foo', password: '123qw').save, "password's length is less than 6 symbols"
  end

  test "create" do
    Admin.create!(login: 'foo', password: '123qwe')
  end
end
