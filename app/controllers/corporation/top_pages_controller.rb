class Corporation::TopPagesController < ApplicationController
  protect_from_forgery

  before_action :corporation_authenticate!

  def show
  end
end
