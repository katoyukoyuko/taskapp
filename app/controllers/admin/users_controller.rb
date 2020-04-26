class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :edit]

  def index
    if admin_user == true
      @users = User.all.includes(:tasks)
    end
  end

  def new
    if admin_user == true
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
      redirect_to admin_user_path(@user.id), notice: t('view.user.edit_message')
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

  def admin_user
    if current_user.admin?
      return true
    else
      redirect_to root_path
      flash[:notice] = 'あなたは管理者ではありません'
    end
  end
end
