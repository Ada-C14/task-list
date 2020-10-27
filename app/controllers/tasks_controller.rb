TASKS = ["get groceries", "take cat to the vet", "take out the trash"]


class TasksController < ApplicationController
  #controller Actions are always methods!
  def index #index means list all
    @tasks = TASKS
  end
end
