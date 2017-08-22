module AdminsHelper
  def authenticate_admin(admin)
    admin.update_column :remember_token, Admin.encrypt(SecureRandom.hex)
    cookies[:login] = admin.login
    cookies[:remember_token] = admin.remember_token
    @current_admin = admin
  end

  def current_admin
    return @current_admin unless @current_admin.nil?
    remember_token = cookies[:remember_token]
    return nil if remember_token.nil?

    admin = Admin.find_by_login cookies[:login]
    if admin.nil? or remember_token != admin.remember_token
      sign_out
      p 'cookies delete login and remember_token'
      return nil
    end
    @current_admin = admin
  end

  def signed_in?
    current_admin.present?
  end

  def sign_out
    login = cookies[:login]
    cookies.delete :login
    cookies.delete :remember_token
    if login
      admin = Admin.find_by_login(login)
      admin.update_column :remember_token, nil if admin
    end
    @current_admin = nil
  end
end
