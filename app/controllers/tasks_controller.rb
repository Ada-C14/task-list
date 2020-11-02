class TasksController < ApplicationController
  #controller Actions are always methods!
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id]
    @task = Task.find_by(id: id)

    if @task.nil?
      redirect_to tasks_path
      #head :not_found #can redirect to 404 page instead here
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    if @task.save #is true
      redirect_to task_path(@task.id)
      return
    else #save failed
      render :new, :bad_request #show the new task form
      return
    end
  end
  #to complete a task, I will want to give the time.now here
  def edit
    id = params[:id]
    @task = Task.find_by(id: id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description]
    ) #if this is true
      redirect_to tasks_path
      return
    else #save failed
      render :edit
      return
    end
  end

  def destroy
    id = params[:id]
    @task = Task.find_by(id: id)

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy

    redirect_to tasks_path
    return
  end

  def complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    elsif @task.completed_at.nil?
      if @task.update(completed_at: Time.now.to_s) # #if true
        redirect_to tasks_path
        return
      else #save failed
        render :edit
        return
      end
    else @task.update(completed_at: nil)
      redirect_to tasks_path
    end
  end
end
