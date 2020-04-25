class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin == true
      @users = User.all.includes(:tasks)
    else
      redirect_to root_path
      flash[:notice] = 'あなたは管理者ではありません'
    end
  end

  def new
    if current_user.admin == true
      @user = User.new
    else
      redirect_to root_path
      flash[:notice] = 'あなたは管理者ではありません'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # session[:user_id] = @user.id
      flash[:notice] = 'ユーザーを作成しました'
      redirect_to admin_users_path
    else
      render :new
    end
    
  end

  def show
    # if current_user != @user
    #   redirect_to root_path
    # else
    # end

  end

  def edit
    if current_user.admin == true
    else
      redirect_to root_path
      flash[:notice] = 'あなたは管理者ではありません'
    end
  end

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
    @user.admin = true
  end
end
