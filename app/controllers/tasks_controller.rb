# TASKS = ['eat', 'sleep', 'read', 'code']

class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show

    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
       redirect_to root_path
    end


  end

  def update

  end

  def edit

  end

  def destroy

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name],
                     description: params[:task][:description],
                     completed_at: params[:task][:completed_at]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      #
    else # save failed :(
    render :new, :bad_request # show the new task form view again

    end
  end
end
