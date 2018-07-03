class UnauthorizedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  delegate :flash, :to => :request

  class << self
    def call env
      @respond ||= action :respond
      @respond.call env
    end
  end

  def respond
    unless request.get?
      message = request.env['warden.options'].fetch(:message, "unauthorized.user")
      flash.alert = I18n.t(message)
    end
    if params["authentication_token"]
      self.response_body = "Unauthorized Action"
      self.status = :unauthorized
    else
      case request.subdomain
      when /^admin/
        redirect_to admin_login_path
      when /^corporation/
        redirect_to corporation_login_path  
      else
        redirect_to new_sessions_path
      end
    end
  end
end