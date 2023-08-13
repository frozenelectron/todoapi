class TodosController < ApplicationController
  before_action :set_task, only: [:destroy, :update, :show]

  #GET todos/
  def index
    @tasks = Task.all
    render json: @tasks
  end

  #GET todos/1
  def show
    render json: @task
  end

  #POST /todos
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  #PATCH/PUT /todos/1
  def update
    if @task.update(task_params)
      render json: @task, status: :updated
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  #DELETE /todos/1
  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end

end
