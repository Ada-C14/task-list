TASKS = [
    {name: "Organize study notes",
    description: "notes should be argonized by subject",
    completed: ""},
    {name: "Finalize study notes",
        description: "notes should be finalized by study buddies",
        completed: "done!"}
]

class TasksController < ApplicationController
    def index
        @tasks =TASKS
    end
end
