TASKS = %w[A B C D]

class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end
end
