# TASKS = [
#     { name: "Grocery List", description: "Write the name of items need to buy", completed_at: "10/26/2020"},
#     { name: "Grocery shop", description: "Go to Trader Joe's to get groceries items", completed_at:"10/30/2020"}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    if id >= 0
       @task = Task.find_by_id(id)
    end
    if @task.nil?
      redirect_to action: :index
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
        completed_at: params[:task][:completed_at])

    if task.save
      redirect_to task_path(task)
    else
      render :new, :bad_request
    end
  end
end


