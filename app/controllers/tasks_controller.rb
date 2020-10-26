# temp variable for tasks until we use database
TASKS = ["Go to QFC", "Send Snail Mail", "Finish Design Document"]
# tasks controller class
class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
