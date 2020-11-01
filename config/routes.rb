Rails.application.routes.draw do

  resources :tasks
  #all tasks
  # get '/tasks', to: 'tasks#index', as: 'tasks'
   root to: 'tasks#index'
  # get '/tasks/new', to: 'tasks#new', as:'new_task'
  # post '/tasks', to: 'tasks#create'
  #
  # #individual task
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
end
