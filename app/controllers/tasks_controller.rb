TASKS = [
    { name: 'Go to work', description: 'Ada', completed_at: 'Oct. 26, 2020'},
    { name: 'Buy a costume', description: 'Halloween', completed_at: 'Oct. 27, 2020'},
    { name: 'Water plants', description: 'Chores', completed_at: 'Oct. 28, 2020'}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
