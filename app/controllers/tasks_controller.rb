# TASKS = [
#     { id: "Task One"},
#     { id: "Task Two"},
#     { id: "Task Three"}
# ]

class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        task_id = params[:id].to_i
        @task = Task[:id]

        if @task.nil?
            head :not_found
            return
        end    
    end
end