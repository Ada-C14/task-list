Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks

  get '/tasks/not_found', to: 'tasks#not_found', as: 'task_not_found'
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_task_complete'

  #7 RESTful routes, replaced with `resources :tasks`
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create'
  #
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'

end
