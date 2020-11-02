class TasksController < ApplicationController
  #Controller Actions are always methods
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    #@task = Task.find(id)
    @task = Task.find_by(id: id)
    if @task.nil?
      # head :not_found
      redirect_to tasks_path

      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :edit # show the new task form view again
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

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )

    if task.save
      redirect_to task_path(task.id) # Send them to the '/tasks' path
    else
      render :new, :bad_request
    end
  end

  def mark_done
    # @task = Task.find_by(id: params[:id])
    # if @task.nil?
    #   redirect_to tasks_path
    #   return
    # elsif @task.mark_done(
    #     name: params[:task][:name],
    #     description: params[:task][:description],
    #     completed_at: params[:task][:completed_at]
    # )
    #   redirect_to tasks_path # go to the index so we can see the task in the list
    #   return
    # else # save failed :(
    # render :edit # show the new task form view again
    # return
    # end
  end
end
