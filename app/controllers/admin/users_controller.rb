class Admin::UsersController < Admin::AdminController

  before_filter :set_controller_crumb, only: [:index,:new,:edit,:show]

  def index
    @page_title = "Users index"
    @action_crumb = "Index"
    @users = User.order(:username)
  end

  def show
    @action_crumb = "User Details"
    @user = User.find(params[:id])
    @page_title = "Show user: &quot;#{@user.username}&quot;"
  end

  def new
    @action_crumb = "New User"
    @user = User.new
    @page_title = "New user"
  end

  def edit
    @action_crumb = "Edit User"
    @user = User.find(params[:id])
    @page_title = "Edit user: &quot;#{@user.username}&quot;"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User was successfully created."
    else
      render :action=>"new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :action=>"edit"
    end
  end

private
  def user_params
    params.require(:user).permit(:username,:first_name,:last_name)
  end

  def set_controller_crumb
    @controller_crumb = {label: "Users", path: admin_users_path}
  end

end
