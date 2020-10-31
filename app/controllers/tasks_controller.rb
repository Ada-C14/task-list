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
        @task = Task.new(name: params[:task][:name], description: params[:task][:description])
        if @task.save
            redirect_to task_path(id: @task[:id])
            return
        else
            redirect_to new_book_path
            return
        end
    end
end
