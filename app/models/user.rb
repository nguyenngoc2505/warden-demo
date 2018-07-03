require 'bcrypt'
class User < ActiveRecord::Base
  before_create :generate_confirmation_token

  has_one :admin
  has_one :corporation

  validates_presence_of :email
  include BCrypt

  def password
    @password ||= Password.new self.encrypted_password
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def confirm!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    self.save!
  end

  private
  def generate_confirmation_token
    token = Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{self.updated_at}")
    self.confirmation_token = token
    self.confirmation_sent_at = Time.now.utc
  end
end
