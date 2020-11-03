Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # requires verb 'path', to: 'controller#action'
  root :to => 'tasks#index'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  # routes that operate on individual tasks
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  get '/tasks/:id', to: 'tasks#show', as: 'task' #get details of 1 task
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task' #changed to patch request
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'

  #delete is next
end
