TASKS = [
    { id: "Task One"},
    { id: "Task Two"},
    { id: "Task Three"}
]

class TasksController < ApplicationController
    def index
        @tasks = TASKS
      end
end