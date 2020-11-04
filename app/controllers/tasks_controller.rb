class TasksController < ApplicationController

  TASKS = [
    {
      id: 1, 
      name: "Wash dishes", 
      completed_at: nil
    
    },

    {
      id: 2, 
      name: "Laundry", 
      completed_at: nil
    
    }
 
  ]

  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @tasks = TASKS[task_id]
    if @tasks.nil?
      head :not_found
      return
    end
  end

end
