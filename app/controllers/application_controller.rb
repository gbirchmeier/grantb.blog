class ApplicationController < ActionController::Base
  before_filter :set_current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #TODO needed?
  def redirect_if_not_logged_in
    unless @current_user
      redirect_to not_allowed_path and return true
    end
    false
  end


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

  def current_correct_url
    # use this when I upgrade to Rails 4.2
    #root = Rails.configuration.try(:x).try(:url_root)

    # hack for current Rails 4.0
    root = "http://staging.grantb.net" if Rails.env.staging?
    root = "http://grantb.net" if Rails.env.production?

    return "#{root}/#{request.original_fullpath}" if root
    return request.original_url
  end

private
  def set_current_user
    current_user()
  end

end
