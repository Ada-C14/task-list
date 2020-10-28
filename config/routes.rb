# config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  # Routes that operate on the task election
  root to: 'tasks#index'
  get '/tasks', to: 'tasks#index'

  # Routes that operate on individual task
  get '/tasks/:id', to: 'tasks#show', as:'task'
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_book'
  # get 'tasks/:id',
end
