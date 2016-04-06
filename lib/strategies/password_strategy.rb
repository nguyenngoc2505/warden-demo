class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    email || password || authentication_token
  end

  def authenticate!
    if authentication_token
      user = User.find_by_authentication_token authentication_token
      user.nil? ? fail!("Could not log in") : success!(user)
    else
      user = User.find_by_email email
      if user.nil? || user.confirmed_at.nil? || user.password != password
        fail!("Could not log in")
      else
        success! user
      end
    end
  end

  private
  def email
    params["session"].try :[], "email"
  end

  def password
    params["session"].try :[], "password"
  end

  def authentication_token
    params["authentication_token"]
  end
end
