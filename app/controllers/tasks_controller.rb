TASKS = [
    { item: "Make Bed", status: "Complete"},
    { item: "Clean Litter Box", status: "Not-complete"},
    { item: "Do Dishes", status: "Not-complete"},
    { item: "Vaccuum Rug", status: "Not-complete"},
    { item: "Fold Laundry", status: "Not-complete"}
]
class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end