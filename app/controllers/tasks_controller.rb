class TasksController < ApplicationController
    def index 
        @tasks = Task.all  
    end

    def show
        task_id = params[:id].to_i
        @task = Task.find_by(id: task_id)
        if @task.nil?
          redirect_to action: "index" 
          return
        end
    end
end
