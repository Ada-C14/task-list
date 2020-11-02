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
        @task = Task.find_by(id: params[:id])

        task_id = params[:id]
        begin 
            @task = Task.find(task_id)
        rescue ActiveRecord::RecordNotFound
            @task = nil
        end

        if @task.nil?
            redirect_to tasks_path
            return
        end
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            head :not_found
            return
        elsif @task.update(
            name: params[:task][:name], 
            description: params[:task][:description], 
            completed_at: params[:task][:completed_at]
            )
            redirect_to task_path # go to the index so we can see the tasks in the list
            return
        else # save failed :(
            render :edit # show the new task form view again
            return
        end
    end

    def destroy
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task
            @task.destroy
            redirect_to tasks_path
            return
        else
            head :not_found  
            return
        end  
    end

    def complete
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task.nil?
            head :not_found
            return
        elsif @task.update(
            completed_at: Time.now.strftime("%m/%d/%Y")
            )
            redirect_to tasks_path
            return
        else
            redirect_to tasks_path
            return
        end
    end
end
