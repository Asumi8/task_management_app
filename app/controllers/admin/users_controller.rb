class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only:[:index, :new, :create, :show, :update, :edit, :destroy]
  skip_before_action :forbid_login_user, only:[:index, :new, :create, :show, :update, :edit, :destroy]
  skip_before_action :prohibit_access_to_other_users, only:[:index,:new, :create, :show, :update, :edit, :destroy]

  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_users_path, notice: "登録しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_params)
      redirect_to admin_users_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.tasks.destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除しました"
  end

  private

  def admin_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
