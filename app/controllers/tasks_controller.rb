class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)

    if @task.save
      redirect_to @task, notice: 'task was successfully created.'
    else
      render :new
    end

  end

  def show
  end

  def edit
  end

  def update

    if @task.update(tasks_params)
      redirect_to @task, notice: 'task was successfully updated.'
    else
      render :edit
    end

  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'task was successfully destroyed.'
  end


  private

  def tasks_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
