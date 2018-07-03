module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :signed_in?, :current_user, :current_admin, :current_corporation
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def current_admin
    warden.user(:admin)
  end

  def current_corporation
    warden.user(:corporation)
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end

  def admin_authenticate!
    warden.authenticate! :admin_login, scope: :admin
  end

  def corporation_authenticate!
    warden.authenticate! :corporation_login, scope: :corporation
  end
end
