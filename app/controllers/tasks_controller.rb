TASKS = ["hey", "girl", "these", "are", "some", "tasks"]

class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end
end
