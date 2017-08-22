class AdminsController < ApplicationController
  def sign_in_page
    @admin = Admin.new
  end
  def sign_in
    pm = params[:admin]
    admin = Admin.find_by_login(pm[:login])
    if admin.nil?
      @admin = Admin.new(login: pm[:login])
      flash.now[:notice] = :not_exist
      render :sign_in_page, status: :unprocessable_entity
    elsif !admin.authenticate(pm[:password])
      @admin = admin
      flash.now[:notice] = :wrong_password
      render :sign_in_page, status: :unprocessable_entity
    else
      authenticate_admin admin
      redirect_to admin_path
    end
  end
  def sign_out_current
    sign_out
    redirect_to signin_path
  end

  private
    def admin_params
      params.require(:admin).permit :login, :password
    end
end
