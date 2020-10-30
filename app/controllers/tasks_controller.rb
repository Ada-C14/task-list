# tasks controller class
class TasksController < ApplicationController
  # READ
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  # CREATE
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name],
                     description: params[:task][:description])
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
    return
    end
  end

  # UPDATE
  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end

    if @task.update(name: params[:task][:name],
                    description: params[:task][:description])
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end
  # DESTROY
end
