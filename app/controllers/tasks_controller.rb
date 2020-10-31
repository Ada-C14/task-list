# TASKS = [
#     {description: "pay bills", date: "10/12", priority: "high"},
#     {description: "shopping", date: "10/25", priority: "low"},
#     {description: "homework", date: "10/30", priority: "high"}
# ]


class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to action: "show"
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(@task.id) #send the user to the /tasks path
      return
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
      redirect_to root_path
      return
    elsif
      @task.update(task_params)
      redirect_to(task_path) # go to the index
      return
    else #save failed
      render :edit  # show the new book from view again
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
      redirect_to tasks_path
    end
  end

  def mark_complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    else
      @task.update(completed_at: Time.now)
      redirect_to root_path
      return
    end
  end

  private

  # strong params
  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
