class ConfirmationsController < ApplicationController
  skip_before_action :authenticate!
  before_action :redirect_if_token_empty!

  def show
    @user = User.where(confirmation_token: params[:token]).first
    if @user.nil?
      flash.alert = "Confirm error"
      redirect_to root_path
    else
      flash.notice =  "User confirmed"
      @user.confirm!
      warden.set_user(@user)
      redirect_to user_path(@user)
    end

  end

  protected
  def redirect_if_token_empty!
    unless params[:token].present?
      flash.alert = "Token empty"
      redirect_to root_path
    end
  end
end
