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
        begin
            @task = Task.find(params[:id])
          rescue => error
            redirect_to root_path, alert: "Error: #{error}"
            return
        end 
    end

    def new
        @task = Task.new
    end    

    def create
        @task = Task.new(task_params)
        
        if @task.save
            redirect_to task_path(@task)
        else
            render :new, :bad_request
            return
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
            redirect_to task_path(@task.id)
            return
        else
            render :edit, :bad_request
            return
        end   
    end    
    
    def destroy
        @task = Task.find_by(id: params[:id])
      
        if @task
          @task.destroy
          redirect_to root_path
        else
          head :not_found
          return
        end
      end

    def toggle_complete

        @task = Task.find_by(id: params[:id])
        
        if @task.nil?
            redirect_to root_path
            return
        elsif @task.update(
            completed_at: Date.current
          )
            redirect_to task_path(@task.id)
            return    
        else
            render :edit, :bad_request
            return
        end  
    end      

    private

    def task_params
        return params.require(:task).permit(:name, :description, :completed_at)
    end  
end