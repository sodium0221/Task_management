class TasksController < ApplicationController
  before_action :set_user
  
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
  
  private
  
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

end 
