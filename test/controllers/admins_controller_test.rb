require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  ADMIN_LOGIN = ENV['ADMIN_LOGIN']
  ADMIN_PASSWORD = ENV['ADMIN_PASSWORD']

  test "visit signin page" do
    get signin_url
    assert response.success?
  end


  test 'valid admin sign in' do
    user_params = {
      login: ADMIN_LOGIN,
      password: ADMIN_PASSWORD
    }
    post signin_url, params: {admin: user_params}
    assert_equal admin_url, response.redirect_url
  end


  test 'sign in with invalid login' do
    admin = admins(:main_admin)
    user_params = {
      login: ADMIN_LOGIN + '_wrong',
      password: ADMIN_PASSWORD
    }
    post signin_url, params: {admin: user_params}
    assert_not response.success?  #
    assert_not response.redirect?
  end


  test 'sign in with invalid password' do
    return
    admin = admins(:main_admin)
    user_params = {
      login: ADMIN_LOGIN,
      password: 'wrong password'
    }
    post signin_url, params: {admin: user_params}
    assert_not response.success?  #
    assert_not response.redirect?
  end
end
