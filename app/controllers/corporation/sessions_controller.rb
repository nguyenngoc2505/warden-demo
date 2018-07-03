class Corporation::SessionsController < ApplicationController

  def create
    corporation_authenticate!
    redirect_to corporation_root_path
  end

  def destroy
    warden.logout(:corporation)
    redirect_to corporation_login_path
  end
end
