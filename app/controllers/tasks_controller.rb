

class TasksController < ApplicationController
  def index
    @tasks = %w(task1, task2, task3)
  end
end
