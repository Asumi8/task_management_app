class UsersController < ApplicationController
  skip_before_action :login_required, only:[:new, :create]
  skip_before_action :forbid_login_user, only:[:show]
  skip_before_action :prohibit_access_to_other_users, only:[:new, :create]


  def  new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
