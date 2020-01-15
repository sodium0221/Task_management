class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :admin_user, only: %i(index destroy)
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end 
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def tasks
    @tasks = User.all
  end 
  
  def edit
    
  end 
  
  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render :edit
    end 
  end 
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end 

  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end 
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end 
end
