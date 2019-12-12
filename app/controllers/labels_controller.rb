class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]
  before_action :not_label_create, only: [:new]

  def not_label_create
    unless logged_in?
      redirect_to root_path, notice: 'ログインしてください'
    end
  end

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to user_path(current_user.id), notice: '登録完了'
    else
      render :new 
    end
  end

  def edit
  end

  def destroy
    @label.destroy
    redirect_to user_path(current_user.id), notice: '情報を削除しました' 
  end

  def show
    
  end

  private
  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name )
  end
end