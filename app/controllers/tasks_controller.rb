class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    if logged_in?
      # @user = current_user
      # binding.irb

      hash = Task.completeds

      if params[:sort_expired]
        # @tasks = Task.all.order(end_at: :desc).page(params[:page]).per(5)
        @tasks = current_user.tasks.all.order(end_at: :asc).page(params[:page]).per(5)
      else
        @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(5)
      end

      if params[:sort_priority]
        @tasks = current_user.tasks.all.order(priority: :asc).page(params[:page]).per(5)
      else
      end

      unless params[:search].nil?
        if params[:name].present? && params[:completed].present?
          @tasks = current_user.tasks.name_like(params[:name]).completed_like(hash[params[:completed]].to_i).page(params[:page]).per(5)
        elsif params[:name].present?
          @tasks = current_user.tasks.name_like(params[:name]).page(params[:page]).per(5)
        elsif params[:completed].present?
          @tasks = current_user.tasks.completed_like(hash[params[:completed]].to_i).page(params[:page]).per(5)
        else
        end
      end
    else
    redirect_to new_session_path, notice: t('view.task.login')
    end

    # @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)

  end

  def new
    @task = Task.new
    @task.user = current_user
  end

  def create
    @task = current_user.tasks.build(tasks_params)

    if @task.save
      redirect_to @task, notice: t('view.task.new_task_complete')
    else
      render :new, notice: t('view.task.new_task_complete')
    end

  end

  def show
  end

  def edit
  end

  def update

    if @task.update(tasks_params)
      redirect_to @task, notice: t('view.task.edit_task_complete')
    else
      render :edit
    end

  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('view.task.destroy_task_complete')
  end


  private

  def tasks_params
    params.require(:task).permit(:name, :description, :end_at, :completed, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
