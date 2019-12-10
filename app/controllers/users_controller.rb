class UsersController < ApplicationController
  before_action :not_user_create, only: [:new]
before_action :set_user, only:[:show, :edit, :update]
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
    if current_user.id != @user.id
      redirect_to tasks_path, notice: 'あなたのアカウントではありません。'
    end
  end

  def edit
    if current_user.id != @user.id
      redirect_to root_path, notice: 'あなたのアカウントではありません。'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました' 
    else
      render :edit 
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end










