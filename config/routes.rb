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


end
