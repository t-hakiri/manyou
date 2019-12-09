class UsersController < ApplicationController
  before_action :not_user_create, only: [:new]

  def new
    @user = User.new
  end

  def not_user_create
    if logged_in?
      redirect_to tasks_path, notice: '新規登録する場合はログアウトしてください。'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end