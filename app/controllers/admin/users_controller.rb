class Admin::UsersController < ApplicationController
  before_action :login?
  before_action :not_admin
  before_action :set_user, only: [:destroy]

  def new
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
      redirect_to root_path, notice: 'ユーザーを削除しました' 
  end

  def update
    if @user.update(user_params)
     redirect_to @user, notice: 'ユーザー情報を更新しました'
    else
      render :edit 
    end
  end

  def edit
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
end