# config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  # Routes that operate on the task election
  root to: 'tasks#index'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  # Routes that operate on individual task
  get '/tasks/:id', to: 'tasks#show', as:'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_book'
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'
end
