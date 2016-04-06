module Warden::Mixins::Common
  def request
    @request ||= ActionDispatch::Request.new(@env)
  end
end
