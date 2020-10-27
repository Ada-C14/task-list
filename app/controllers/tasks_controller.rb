TASKS = [
    {item: "wash dog"},
    {item: "wash dishes"},
    {item: "wash hair"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
