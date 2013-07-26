class ApplicationController < ActionController::Base
  before_filter :set_current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


#private

  def current_user
    unless @current_user
      user = nil
      if session[:user_id]
        user = User.find(session[:user_id])
#      elsif cookies[:auth_token]
#        user = User.find_by_auth_token!(cookies[:auth_token])
      end
      @current_user ||= user
    end
    return @current_user
  rescue => e
    Rails.logger.error e.inspect
    session[:user_id] = nil
    nil
  end

private
  def set_current_user
    current_user()
  end

end
