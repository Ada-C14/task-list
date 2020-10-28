#temp
TASKS = [
    {title: "clean the bathroom"},
    {title: "clean the kitchen"},
    {title: "do laundry"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
