class Admin::UsersController < ApplicationController
  before_action :login?
  before_action :not_admin
  before_action :set_user, only: [:destroy, :edit, :update, :show]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました' 
  end

  def update
    @users = User.all
    if params[:admin_false] == 'true' && User.where(admin: true).count == 1
      redirect_to admin_users_path, notice: '管理ユーザが一人しかいないので消せません。'
    elsif @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報を更新しました'
    else
      render :edit 
    end
  end

  def edit
  end

  def show
    @tasks = Task.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを新規作成しました。'
    else
      render 'new'
    end
  end

  private

  def login?
    unless logged_in?
      redirect_to root_path, notice: 'ログインしてください'
    end
  end

  def not_admin
    redirect_to root_path, notice: 'No' unless current_user.try(:admin?)
  end 

  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
