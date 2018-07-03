require Rails.root.join('lib/strategies/password_strategy')
require Rails.root.join('lib/strategies/basic_auth_strategy')
require Rails.root.join('lib/strategies/admin_login_strategy')
require Rails.root.join('lib/strategies/corporation_login_strategy')

Warden::Strategies.add(:password, PasswordStrategy)
Warden::Strategies.add(:basic_auth, BasicAuthStrategy)
Warden::Strategies.add(:admin_login, AdminLoginStrategy)
Warden::Strategies.add(:corporation_login, CorporationLoginStrategy)
