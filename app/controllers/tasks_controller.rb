TASKS = [
    { task: "review notes from the beginning of time" },
    { task: "clean my room dammit" },
    { task: "code a pretty website for once" },
    { task: "cuss at my computer less and just code better" },
    { task: "fix my dysfunctional sleeping schedule" },
    { task: "go outside and enjoy nature while it lasts" },
    { task: "eat more veggies and drink more water" },
    { task: "stop procrastinating HAHA jk as if that'll ever happen" },
    { task: "get my shit together x100 on god" }
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
