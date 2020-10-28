TASKS = [
  { description:  "repot plants", due: "Monday" },
  { description: "eat donut", due: "Tuesday" },
  { description:  "attend yoga", due: "Wednesday" }
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
