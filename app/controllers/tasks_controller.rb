class TasksController < ApplicationController
  #controller Actions are always methods!
  def index #index means list all
    @tasks = Task.all
  end
end
