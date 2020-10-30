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

    def new
        @task = Task.new
    end    

    def create
        @task = Task.new(
            name: params[:task][:name], 
            description: params[:task][:description], 
            completed_at: params[:task][:completed_at]
            )
        
        if task.save
            redirect_to tasks_path
        else
            render :new, :bad_request
            return
        end 
    end               

    def edit
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task.nil?
            head :not_found
            return   
        end             
    end

    def create
        @task.update(
            name: params[:task][:name], 
            description: params[:task][:description], 
            completed_at: params[:task][:completed_at]
            )
        
        if @task.update
            redirect_to task
        else
            render :edit, :bad_request
            return
        end   
    end    
    
    def destroy
    end    

    def create
    end    

end