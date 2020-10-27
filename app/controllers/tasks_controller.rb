TASKS = ["Do laundry", "Wash dogs", "Buy new sheets"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
