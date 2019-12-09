class Admin::UsersController < ApplicationController
  before_action :login?
  before_action :not_admin
  before_action :set_user, only: [:show, :edit, :destroy]

  def new
  end

  def index
    @users = User.all
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