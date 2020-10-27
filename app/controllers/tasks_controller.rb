TASKS = ["Watch cs fun video", "Do the laundry", "Answer 2 emails"]

class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end
end
