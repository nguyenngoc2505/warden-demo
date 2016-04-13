require Rails.root.join('lib/strategies/password_strategy')
require Rails.root.join('lib/strategies/basic_auth_strategy')

Warden::Strategies.add(:password, PasswordStrategy)
Warden::Strategies.add(:basic_auth, BasicAuthStrategy)
