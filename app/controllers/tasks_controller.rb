
TASKS = [
    {todo: "Walk the dog"},
    {todo: "Make the mung beans"},
    {todo: "Go to the wine store"},
    {todo: "Eat a vegetable"},
    {todo: "Call your girl"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
