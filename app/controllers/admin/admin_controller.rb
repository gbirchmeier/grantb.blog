class Admin::AdminController < ApplicationController
  layout "admin"

  before_action :credit_check

private
  def credit_check
    redirect_to not_allowed_path unless @current_user
  end
end
