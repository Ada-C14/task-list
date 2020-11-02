Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index', as: 'tasks'
  root to: 'tasks#index'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks/', to: 'tasks#create'
end
