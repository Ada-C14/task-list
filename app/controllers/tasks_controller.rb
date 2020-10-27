TASKS = [
    { type: "School", priority: "High" },
    { type: "Home", priority: "Medium" },
    { type: "Personal", priority: "Medium" }
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
