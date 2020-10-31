# TASKS = [
#     { name: 'Go to work', description: 'Ada', completed_at: 'Oct. 26, 2020'},
#     { name: 'Buy a costume', description: 'Halloween', completed_at: 'Oct. 27, 2020'},
#     { name: 'Water plants', description: 'Chores', completed_at: 'Oct. 28, 2020'}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to '/tasks'
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )

    if task.save
      redirect_to task_path(task)
    else
      render :new, :bad_request
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
