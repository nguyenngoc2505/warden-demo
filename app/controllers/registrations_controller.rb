class RegistrationsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "Registrations User Success"
      redirect_to root_path
    end
  end

  private
  def user_params
    params[:user].permit!
  end
end
