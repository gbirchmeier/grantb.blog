class SessionsController < ApplicationController
  def new
    @login_error = nil
    redirect_to root_path unless @current_user.nil?
  end

  def destroy
#    cookies.delete(:auth_token)
#    cookies.delete(:remember_me)
my_user = current_user
    session[:user_id] = nil
    redirect_to login_path, :alert => "#{my_user.username} logged out."
  end

  def create
    @login_error = nil
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])

#      if params[:remember_me]
#        cookies.permanent[:auth_token] = user.auth_token
#        cookies.permanent[:remember_me] = true
#      end
      session[:user_id] = user.id
#      if session[:return_to]
#        path = session[:return_to]
#        session[:return_to] = nil
#        redirect_to path
#      else
        redirect_to root_path
#      end
    else
      @login_error = "Invalid username or password"
      render "new"
    end
  end

end
