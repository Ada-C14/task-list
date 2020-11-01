class TasksController < ApplicationController
  # Tasks = [
  #     {name: "The First Task", description: "", completed_at: random_time},
  #     {name: "Go to Brunch", description: ""},
  #     {name: "Go to Lunch", description: "", completed_at: random_time},
  #     {name: "Go to Second Lunch", description: ""},
  #     {name: "Play Video Games", description: "", completed_at: random_time},
  #     {name: "High Five Somebody You Don't Know", description: "", completed_at: random_time},
  #     {name: "Plant Flowers", description: "", completed_at: random_time},
  #     {name: "Call Mom", description: ""},
  #     {name: "She worries, you know.", description: ""},
  #     {name: "Nap.", description: "", completed_at: random_time},
  # ]

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
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(@task.id) #send the user to the /tasks path
      return
    else
      render :new
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
    elsif @task.update(task_params)
      redirect_to tasks_path(@task.id) # go to the index
      return
    else #save failed
      render :edit  # show the new book from view again
    end
  end


  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
      return
    else
      task.destroy
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
