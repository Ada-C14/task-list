# TASKS = ["Watch cs fun video", "Do the laundry", "Answer 2 emails"]

class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show 
        task_id = params[:id]
        
        begin 
            @task = Task.find(task_id)
        rescue ActiveRecord::RecordNotFound
            @task = nil
        end

        if @task.nil?
            # head :not_found
            redirect_to tasks_path
            return
        end
    end

    def new
        @task = Task.new
    end

    def create
         #instantiate a new task
        @task = Task.new(
            name: params[:task][:name], 
            description: params[:task][:description], 
            completed_at: params[:task][:completed_at])

        if @task.save # save returns true if the database insert succeeds
            redirect_to task_path @task.id # go to the show so we can see the task page
            return
        else # save failed :(
            render :new # show the new task form view again
            return
         end
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
