TASKS = [ "Buy groceries", "Take out the trash", "Take the dog for a walk", "Do laundry"  ]



class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
