class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

#   def show
#     @task = TASKS[0]
#   end
end