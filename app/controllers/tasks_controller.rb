class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def toppage
  end

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all.sorted.page(params[:page]).per(5)
    if params[:sort_expired] == "true"
      @tasks = Task.all.deadline_sort.page(params[:page]).per(5)
    elsif params[:task].present?
      @tasks = Task.title_search(params[:task][:title_search]).page(params[:page]).per(5)
      if params[:task][:status_search].present?
        @tasks = @tasks.status_search(params[:task][:status_search]).page(params[:page]).per(5)
      end
    elsif params[:sort_priority] == "true"
      @tasks = Task.all.sort_priority.page(params[:page]).per(5)
    end
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
      redirect_to tasks_path, notice: '情報の編集が完了しました' 
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
    params.require(:task).permit(:title, :content, :deadline, :priority, :status )
  end
end
