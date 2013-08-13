class AdminController < ApplicationController

  def index
    unless @current_user
      redirect_to not_allowed_path and return
    end
  end

end
