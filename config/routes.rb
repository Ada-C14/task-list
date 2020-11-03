Rails.application.routes.draw do
  # Routes for all tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get 'tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  # Routes for using a specific task page
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'
  get '/tasks/:id/confirm_delete', to: 'tasks#confirm', as: 'confirm_task'
  delete '/tasks/:id', to: 'tasks#delete', as: 'delete_task'
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  root to: 'tasks#index'
end
