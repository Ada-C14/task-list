Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  get '/tasks', to: 'tasks#index'
  get '/tasks/:id', to: 'tasks#show', as: 'task'

  get '/tasks/:id/edit', to:'tasks#edit', as: 'edit_task'
  patch 'tasks/:id', to: 'tasks#update', as: 'update_task'

  delete '/tasks/:id', to: 'tasks#delete', as: 'delete_task'

  patch 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  patch 'tasks/:id/uncomplete', to: 'tasks#uncomplete', as: 'uncomplete_task'


  root to:'tasks#index'

end
