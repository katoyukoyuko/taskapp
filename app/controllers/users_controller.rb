class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to user_path(@user.id)
    else
      render :new
    end
    
  end

  def show
    if current_user != @user
      redirect_to root_path
    else
    end

  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: t('view.user.edit_message')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
