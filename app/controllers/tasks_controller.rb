# TASKS = [
#   { to_do_list: "Hidden Figures", due_date: "Margot Lee Shetterly"},
#   { to_do_list: "Practical Object-Oriented Design in Ruby", due_date: "Sandi Metz"},
#   { to_do_list: "Kindred", due_date: "Octavia E. Butler"}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    
  end
end
