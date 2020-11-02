Rails.application.routes.draw do

  resources :tasks
  root to: 'tasks#index'
  patch '/tasks/:id/toggle', to: 'tasks#mark', as: 'mark_complete'
  get '/tasks/:id/toggle', to: 'tasks#mark'

  #all tasks
  # get '/tasks', to: 'tasks#index', as: 'tasks'

  # get '/tasks/new', to: 'tasks#new', as:'new_task'
  # post '/tasks', to: 'tasks#create'
  #
  # #individual task
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # patch '/tasks/:id', to: 'tasks#update'
  #

end
