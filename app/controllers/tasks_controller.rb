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


end
