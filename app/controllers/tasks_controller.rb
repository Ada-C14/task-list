TASKS = [
  "Do dishes",
  "Fold laundry",
  "Water plants"
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
