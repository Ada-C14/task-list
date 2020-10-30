Rails.application.routes.draw do

  #all tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  root to: 'tasks#index'

  #individual task
  get '/tasks/:id', to: 'tasks#show', as: 'task'
end
