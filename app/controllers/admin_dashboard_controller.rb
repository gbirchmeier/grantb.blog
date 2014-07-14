class AdminDashboardController < ApplicationController
  layout "admin"

  def index
    redirect_if_not_logged_in and return
  end

end
