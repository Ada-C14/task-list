# TASKS = ['eat', 'sleep', 'read', 'code']

class TasksController < ApplicationController


  def index
    @books = Task.all
  end
end
