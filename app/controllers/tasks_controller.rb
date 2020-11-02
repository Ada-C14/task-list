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
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    if task.save
      redirect_to task_path(task)
    else
      render :new, :bad_request
    end
  end

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
      head :not_found
      return
    elsif @task.update(task_params)
      redirect_to tasks_path  # go to the index so we can see the task in the list
      return
    else  # save failed
      render :edit  # show the new task form view again
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    else
      @task.destroy
      redirect_to root_path
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    else
      if @task.completed_at.nil?
        @task.update(completed_at: Time.now.strftime("%B %e, %Y %I:%M%p"))
      else
        @task.update(completed_at: nil)
      end
      redirect_to tasks_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
