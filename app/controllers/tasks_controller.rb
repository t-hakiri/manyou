class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def toppage
  end

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '登録完了'
    else
      render :new 
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: '情報の編集が完了しました' 
    else
      render :edit
    end

  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: '情報を削除しました' 
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content )
  end
end
