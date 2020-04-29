class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new, :edit]

  def index
    if require_admin == true
      @users = User.all.includes(:tasks)
    end
  end

  def new
    if require_admin == true
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'ユーザーを作成しました'
      redirect_to admin_users_path
    else
      render :new
    end
    
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: t('view.user.edit_message')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('view.user.destroy_message')
    else
      redirect_to admin_users_path, notice: t('view.user.destroy_errer')
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user.admin?
      flash[:notice] = 'あなたは管理者ではありません'
      redirect_to root_path
    else
      return true
    end
  end
end
