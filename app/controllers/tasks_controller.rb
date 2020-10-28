# TASKS = ["groceries", "mop floor", "pay bills", "get a job"]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

end
