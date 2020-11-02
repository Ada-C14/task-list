# TASKS = [
#     {name: "exercise (begrudgingly)"},
#     {name: "grocery shop"},
#     {name: "tend to Kirby, the small dog"},
#     {name: "force brain to learn"},
#     {name: "fight off sense of future dread"},
#     {name: "make dinner"},
#     {name: "pick up packages"}
# ]

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
      redirect_to task_path # go to the index so we can see the book in the list
      return
    else # save failed :(
    render :edit # show the new book form view again
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

    if @task.nil?
      redirect_to tasks_path
      return
    end


    @task.destroy

    redirect_to tasks_path
    return

  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at])

    if task.save
      redirect_to task_path(task) #send to index
    else
      render :new
    end

  end


  def mark_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    elsif @task.completed_at == "" || @task.completed_at == nil
      @task.completed_at = Time.now.to_s
      @task.save
      redirect_to tasks_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      redirect_to tasks_path # show the new book form view again
      return
    end
  end

  def mark_incomplete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    elsif @task.completed_at != "" || @task.compeleted_at != nil
      @task.completed_at = ""
      @task.save
      redirect_to tasks_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      redirect_to tasks_path # show the new book form view again
      return
    end
  end


end
