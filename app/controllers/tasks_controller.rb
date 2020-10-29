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
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task.nil?
            head :not_found
            return
        end    
    end

    def update
    end
    
    def edit
    end
    
    def destroy
    end    

    def create
    end    

end