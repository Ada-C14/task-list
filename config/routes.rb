Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  # routes for all tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # get form for new task
  post '/tasks', to: 'tasks#create'

  # routes about specific tasks
  get '/tasks/:id', to: 'tasks#show', as: 'task' # task details
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'  # form for editing book
  patch '/tasks/:id', to: 'tasks#update'
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  delete '/tasks/:id', to: 'tasks#destroy'

end
