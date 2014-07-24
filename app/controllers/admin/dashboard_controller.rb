class Admin::DashboardController < ApplicationController
  layout "admin"

  before_action :credit_check

  def index
    redirect_if_not_logged_in and return
  end

self
  def credit_check
    redirect_to not_allowed_path unless @current_user
  end

end
