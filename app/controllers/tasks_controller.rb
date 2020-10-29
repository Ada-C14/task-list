TASKS = ['eat', 'sleep', 'read', 'code']

class TasksController < ApplicationController


  def index
    @tasks = TASKS
  end
end
