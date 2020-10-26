class TasksController < ApplicationController
  TASKS = [
      {description: "pay bills", date: "10/12", priority: "high"},
      {description: "shopping", date: "10/25", priority: "low"},
      {description: "homework", date: "10/30", priority: "high"}
  ]

  def index
    @tasks = TASKS
  end

end
