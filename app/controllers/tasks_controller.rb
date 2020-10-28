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
    @tasks = Tasks
  end

  def show
    # task_id = params[:id].to_i
    # @task = TASKS[task_id]
    # if @task.nil?
    #   head :not_found
    #   return
  end

end
