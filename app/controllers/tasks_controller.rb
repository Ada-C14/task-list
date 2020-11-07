
#model is the blueprint of the database
#database knows what data you will give it
#rails generate model task name:string description:string completed_at:string
# Running via Spring preloader in process 71235
# rails db:migrate
# rails server
# rails console
# [1] pry(main)> t = Task.new /or t = Task.create which also saves it
#  t.name = "eat"
# t.description = "make dinner"
#  t.completed_at = "7:00pm"
# t.save
class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end


  def create
    @task = Task.new(tasks_params) #instantiate a new task
    if @task.save
      redirect_to root_path # see the task in the index list
      return
    else # save failed
    render :new, status: :bad_request # show the new task form view again
    return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    elsif @task.update(task_params)
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed
    render :edit, status: :bad_request # show the new task form view again
    return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy

    redirect_to tasks_path
    return
  end

  private

  def tasks_params
    return params.require(:task).permit(:id, :description, :completed_at)
  end

end
