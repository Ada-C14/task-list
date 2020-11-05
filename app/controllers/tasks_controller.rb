class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  # Why does new method need content
  # It's an empty object, but it needs an object to view (should wnt a class but it wants an instance)
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :new # show the new task form view again
    return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      # head :not_found #, status: :not_found
      return
    elsif
      @task.update(
          name: params[:task][:name],
          description: params[:task][:description]
      )
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def completed_at
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    elsif
    @task.update(
        completed_at: DateTime.now,
    )
      redirect_to tasks_path
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to tasks_path
    elsif
      render :notfound, status: :not_found
    else @task.nil?
      head :not_found
      return
    end
  end
end
