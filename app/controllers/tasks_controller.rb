
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

  #Controller Actions are always methods
  def index #index means list all
    @tasks = Task.all # where is Task defined? right here.
    #.all Retrieving Multiple Objects in Batches becomes expensive as the table size increases
  end

  def show
    # task_id = params[:id].to_i
    # @task = TASKS[task_id]
    #
    # @task = Task.find(params[:id]) #why use find here?
    #
    # if @task.nil?
    #   head :not_found
    #   return
    # end
  end

end
