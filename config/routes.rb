Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # requires verb 'path', to: 'controller#action'
  root :to => 'tasks#index'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  # routes that operate on indvidual tasks
  get '/tasks/:id', to: 'tasks#show', as: 'task' #get details of 1 task
end
