TASKS = ["wash dishes", "change smoke detector batteries", "alphabetize garage", "solve ancient mysteries of universe"]


class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
