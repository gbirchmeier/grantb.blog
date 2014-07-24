class Admin::DashboardController < Admin::AdminController

  def index
    redirect_if_not_logged_in and return
  end

end
