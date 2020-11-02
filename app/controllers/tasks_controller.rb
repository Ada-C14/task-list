TASKS = %w[A B C D]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end
end
