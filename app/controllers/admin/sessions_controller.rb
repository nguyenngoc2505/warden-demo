class Admin::SessionsController < ApplicationController

  def create
    admin_authenticate!
    redirect_to admin_root_path
  end

  def destroy
    warden.logout(:admin)
    redirect_to admin_login_path
  end
end
