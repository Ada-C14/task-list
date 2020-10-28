TASKS = ["be cool", "be calm", "be collected", "lose your ever-loving mind"]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
end
