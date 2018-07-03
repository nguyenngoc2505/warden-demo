class Admin::TopPagesController < ApplicationController
	protect_from_forgery

	before_action :admin_authenticate!

  def show
  end
end
