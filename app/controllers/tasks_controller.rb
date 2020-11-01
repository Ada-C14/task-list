# TASKS = [
#     { task: "review notes from the beginning of time" },
#     { task: "clean my room dammit" },
#     { task: "code a pretty website for once" },
#     { task: "cuss at my computer less and just code better" },
#     { task: "fix my dysfunctional sleeping schedule" },
#     { task: "go outside and enjoy nature while it lasts" },
#     { task: "eat more veggies and drink more water" },
#     { task: "stop procrastinating HAHA jk as if that'll ever happen" },
#     { task: "get my shit together x100 on god" }
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed_at: params[:task][:completed_at])

    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end
end
