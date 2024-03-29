class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: %i(show edit update destroy)
  def top
  end

  
  def index
    @tasks = @user.tasks
  end 
  
  def show
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def new
    @task = Task.new
  end 
  
  def create 
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました"
      redirect_to user_tasks_url @user
    else 
      render :new
    end 
  end 
  
  def edit
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def destroy
    @task = @user.tasks.find_by(id: params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました"
    redirect_to user_tasks_url @user
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to user_tasks_url(@user)
    else
      render :edit
    end 
  end 
  
  private
  
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません"
        redirect_to user_tasks_url @user
      end 
    end 

end 
