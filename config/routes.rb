Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  #Routes to operate on tasks collection
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create', as: 'created_task'

  #Routes to operate on individual task
  get '/tasks/:id', to: 'tasks#show', as: 'task'
end
