Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  # routes for all tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # get form for new task
  post '/tasks', to: 'tasks#create'

  # routes about specific tasks
  get '/tasks/:id', to: 'tasks#show', as: 'task' # task details
<<<<<<< HEAD
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'  # form for editing book
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#delete'
=======
  get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'  # form for editing book
  patch 'tasks/:id', to: 'tasks#update'
  delete 'tasks/:id', to: 'tasks#delete'
>>>>>>> bdef91f4ffdd9d862b734454698e7d5c8d84ab6f
end
