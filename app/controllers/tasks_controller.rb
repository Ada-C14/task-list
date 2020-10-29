TASKS = [
    {name: "Groceries"},
    {name: "Laundry"},
    {name: "Dishes"},
    {name: "Pack"},
    {name: "Homework/Study"},
    {name: "Volunteer"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
