# TASKS = [
#     {description: "pay bills", date: "10/12", priority: "high"},
#     {description: "shopping", date: "10/25", priority: "low"},
#     {description: "homework", date: "10/30", priority: "high"}
# ]


class TasksController < ApplicationController


  def index
    @tasks = Book.all
  end


  def show
    book_id = params[:id]
    @book = Book.find_by(id: book_id)
    if @book.nil?
      head :not_found
      return
    end
  end

end
