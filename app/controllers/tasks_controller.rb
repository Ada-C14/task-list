TASKS = ["groceries", "mop floor", "pay bills", "get a job"]

class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end

end
