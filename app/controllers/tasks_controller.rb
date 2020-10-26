TASKS = [
    { task: "Clean kitchen", checkbox: "Complete"},
    { task: "Organize files", checkbox: "Not-complete"},
    { task: "Bathe Hugo", checkbox: "Not-complete"}
]
class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
