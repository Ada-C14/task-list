Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/' to: 'tasks#root', as: 'root'

  root to: 'tasks#index'
  patch 'tasks/:id/toggle', to: 'tasks#mark_complete', as: 'mark_complete'
  resources :tasks


  ### the 7 RESTFUL routes: ###

  # get '/tasks', to: 'tasks#index'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  #
  # post '/tasks', to: 'tasks#create'
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch 'tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'


end

