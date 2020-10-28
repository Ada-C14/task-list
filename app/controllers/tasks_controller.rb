TASKS = [
    { name: "Grocery List", description: "Write the name of items need to buy", completed_at: "10/26/2020"},
    { name: "Grocery shop", description: "Go to Trader Joe's to get groceries items", completed_at:"10/30/2020"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    id = params[:id].to_i
    if id >= 0
       @task = TASKS[id]
    end
    if @task.nil?
      redirect_to action: :index
      return
    end
  end
end


