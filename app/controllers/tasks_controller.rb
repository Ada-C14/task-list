TASKS = ["Write Jeremy happy birthday", "Find credit card", "BECU Fraud", "Apple Care"]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id] #we'll be able to access our route parameter via a special hash provided by Rails called params. The ID sent by the browser will be stored under the key :id (remember that this is the name we gave the parameter in the routefile).
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end

end

# def show
#   book_id = params[:id]
#   @book = Book.find_by(id: book_id)
#   if @book.nil?
#     head :not_found
#     return
#   end
# end