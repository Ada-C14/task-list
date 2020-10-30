# TASKS = [{name:'mop the floor'}, {name:'take out the garbage'}, {name:'change the cat litter box'}, {name:'fold clothes'} ]

class TasksController < ApplicationController

  #Controller Actions are always methods!
  def index # index means list all
    @tasks = Task.order(:name)
  end

  def show # details of an instance of an object
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

  def new 
  end

  def create
  end

  def destroy
  end
  
end
