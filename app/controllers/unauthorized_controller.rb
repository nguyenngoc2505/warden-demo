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
      message = env['warden.options'].fetch(:message, "unauthorized.user")
      flash.alert = I18n.t(message)
    end
    if params["authentication_token"]
      self.response_body = "Unauthorized Action"
      self.status = :unauthorized
    else
      redirect_to new_sessions_url
    end
  end
end