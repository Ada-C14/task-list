
class TasksController < ApplicationController
    
    def index
        @tasks =Task.all
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
        if @task.save
            redirect_to task_path(@task)
            return
        else
            render :new
            return
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        result = @task.update({
            name: params[:task][:name],
            description: params[:task][:description],
            completed_at: params[:task][:completed_at]
        })

        if result
            redirect_to task_path(@task.id)
        else
            render :edit
        end
    end

end
