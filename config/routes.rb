# config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  # Routes that operate on the task election
  root to: 'tasks#index'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  # Routes that operate on individual task
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id/', to: 'tasks#destroy'
  patch 'tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
end

