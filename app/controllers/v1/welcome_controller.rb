class V1::WelcomeController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    render json: {text: "Welcome"}
  end
end
