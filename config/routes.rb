Rails.application.routes.draw do
    #root to controller#action
    root to: 'tasks#index'
    resources :tasks
    patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

#  #routes that operate with a task collection 
#  # verb 'path', to: 'controller#action'
#  get '/tasks', to: 'tasks#index', as: 'tasks'
#  root to: 'tasks#index'
#  get '/tasks/new', to: 'tasks#new', as: 'new-task'
#  post '/tasks', to: 'tasks#create'

#  #routes that operates on individual books
#  get '/tasks/:id', to: 'tasks#show', as: 'task'
#  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
#  patch '/tasks/:id', to: 'tasks#update'
#  delete '/tasks/:id', to: 'tasks#destroy'
#  
end
