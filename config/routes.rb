Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # all tasks
  root to: 'tasks#index'
  resources :tasks
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'task_complete'
  patch '/tasks/:id/incomplete', to: 'tasks#incomplete', as: 'task_incomplete'
  #keeping this as future reference
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  #
  # # individual task
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
end

