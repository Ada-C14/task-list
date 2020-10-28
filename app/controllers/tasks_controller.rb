TASKS = [ 
  { description: 'Make dinner', completed: false },
  { description: 'Drink my tea', completed: false },
  { description: 'Pay tuition', completed: false }
].freeze




class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
end
