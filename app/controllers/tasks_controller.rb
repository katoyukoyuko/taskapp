class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    if params[:sort_expired]
      @tasks = Task.all.order(end_at: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    unless params[:search].nil?
      if params[:name].present? && params[:completed].present?
        @tasks = Task.name_like(params[:name]).completed_like(params[:completed].to_i)
      elsif params[:name].present?
        @tasks = Task.name_like(params[:name])
      elsif params[:completed].present?
        @tasks = Task.completed_like(params[:completed].to_i)
      else
      end
    end

    @tasks = Task.all.page(params[:page]).per(5)

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)

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
