class CorporationLoginStrategy < ::Warden::Strategies::Base
  def valid?
    email || password
  end

  def authenticate!
    user = User.find_by_email email
    corporation = user&.corporation
    if user && corporation && user.password == password
      success! corporation
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
