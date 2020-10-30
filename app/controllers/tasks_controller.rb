# tasks controller class
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    begin
      @task = Task.find(params[:id])
    rescue StandardError
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name],
                     description: params[:task][:description],
                     completed_at: params[:task][:completed_at]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the book in the list
      return
    else # save failed :(
    render :new # show the new book form view again
    return
    end
  end
end
