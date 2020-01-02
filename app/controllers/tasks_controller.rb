class TasksController < ApplicationController
  def top
  end

  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end 
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def new
    @task = Task.new
    @user = User.find(params[:user_id])
  end 
  
  def create 
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
    if @task.save
      flash[:success] = "タスクを新規作成しました"
      redirect_to user_tasks_url @user
    else 
      render :new
    end 
  end 
  
  def edit
  end
end 
