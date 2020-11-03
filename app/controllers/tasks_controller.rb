# TASKS = ["take out trash", "buy toothpaste", "do homework", "buy Rails for Dummies book"]

class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find_by(id: params[:id])
        if @task.nil? == true
            head :temporary_redirect
            return
        end
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed_at: nil)
        if @task.save
            redirect_to task_path(id: @task[:id])
            return
        else
            redirect_to new_task_path
            return
        end
    end

    def edit
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            head :temporary_redirect
            return
        end
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            head :temporary_redirect
        elsif @task.update(
            name: params[:task][:name],
            description: params[:task][:description],
            completed_at: nil
        )
            redirect_to task_path(id: @task[:id])
            return
        else
            render :edit
            return
        end
    end

    def destroy
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            redirect_to root_path
            return
        else
            @task.destroy
            redirect_to root_path
            return
        end
    end

    def complete
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            redirect_to root_path
            return
        elsif @task.completed_at == nil
            @task.update(completed_at: Time.now)
            redirect_to root_path
            return
        elsif @task.completed_at != nil
        @task.update(completed_at: nil)
            redirect_to root_path
            return
        end
    end

end
