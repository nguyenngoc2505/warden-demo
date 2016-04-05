class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    email || password
  end

  def authenticate!
    user = User.find_by_email email
    if user.nil? || user.confirmed_at.nil? || user.password != password
      fail!("Could not log in")
    else
      success! user
    end
  end

  private
  def email
    params["session"].try :[], "email"
  end

  def password
    params["session"].try :[], "password"
  end
end
