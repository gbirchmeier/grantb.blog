class SessionsController < ApplicationController
  def new
    @page_title = "Sign In"
    @login_error = nil
    redirect_to root_path unless current_user().nil?
  end

  def destroy
    @page_title = "You are signed out."
#    cookies.delete(:auth_token)
#    cookies.delete(:remember_me)
    my_user = current_user()
    session[:user_id] = nil
    if my_user
      redirect_to login_path, :alert => "You are signed out." and return
    end
    redirect_to login_path
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
