require "time"
TASKS = [
    { name: "Do laundry", description: "Do the damn laundry", date_completed: Time.now},
    { name: "Do dishes", description: "Do the damn dishes", date_completed: Time.new(1989)},
    { name: "Cry in bed", description: "Waaahhh", date_completed: Time.new(1969)},
]
class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
