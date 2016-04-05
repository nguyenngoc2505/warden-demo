module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :signed_in?, :current_user

    prepend_before_action :authenticate!
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end
