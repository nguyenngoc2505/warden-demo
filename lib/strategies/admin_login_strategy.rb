class AdminLoginStrategy < ::Warden::Strategies::Base
  def valid?
    email || password
  end

  def authenticate!
    user = User.find_by_email email
    admin = user&.admin
    if user && admin && user.password == password
      success! admin
    else
      fail!("Could not log in")
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
