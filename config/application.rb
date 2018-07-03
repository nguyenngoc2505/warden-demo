require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WardenDemo
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    Warden::Manager.serialize_into_session do |user|
      user.id
    end
    Warden::Manager.serialize_from_session do |id|
      User.find_by_id id
    end

    Warden::Manager.serialize_into_session(:admin) { |user| user.id }
    Warden::Manager.serialize_from_session(:admin) { |id| Admin.find_by_id(id) }

    Warden::Manager.serialize_into_session(:corporation) { |user| user.id }
    Warden::Manager.serialize_from_session(:corporation) { |id| Corporation.find_by_id(id) }


    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies :password, :basic_auth, :admin_login, :corporation_login
      manager.default_scope = :user

      manager.scope_defaults :user,        :strategies => [:password]
      manager.scope_defaults :admin,       :strategies => [:admin_login]
      manager.scope_defaults :corporation, :strategies => [:corporation_login]

      manager.failure_app = UnauthorizedController
    end
  end
end
