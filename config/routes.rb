Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  root to: 'tasks#index'

  # show all the tasks
  get "/tasks", to: "tasks#index", as: 'tasks'

  # get form to add new task
  get "/tasks/new", to: 'tasks#new', as: 'new_task'

  # show each task
  get "/tasks/:id", to: 'tasks#show', as: 'task'

  # create a task
  post "/tasks", to: 'tasks#create'

  # get edit form
  get "/tasks/:id/edit", to: 'tasks#edit', as: 'edit_task'

  # edit the task
  patch "/tasks/:id", to: 'tasks#update'

  # delete task
  delete "/tasks/:id", to: 'tasks#destroy'

  # get a... complete task?

  # mark the completed at
  patch "/tasks/complete/:id", to: 'tasks#complete', as: "complete_task"


end
