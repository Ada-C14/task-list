Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  #root to: 'tasks#index' #root url base url is routed to index

  #routes that operate on the task collection
  #get '/tasks', to: 'tasks#index', as: 'tasks'
  #get '/tasks/new', to: 'tasks#new', as: 'new_task'
  #post 'tasks', to: 'tasks#create'


  #routes that operate on individual tasks
  #get '/tasks/:id', to: 'tasks#show', as: 'task'
  #get 'tasks/:id/edit' , to: 'tasks#edit', as: 'task'
  #patch '/tasks/:id', to: 'tasks#update', as: 'task'
  # delete '/tasks/:id', to: 'tasks#destroy', as: 'task'

end
