Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'

  root 'tasks#index'

  # Routes that operate on tasks
  get '/tasks', to: 'tasks#index', as: :tasks
  get '/tasks/new', to: 'tasks#new', as: :new_task
  post '/tasks', to: 'tasks#create'

  # Routes that operate on an individual task
  get '/tasks/:id', to: 'tasks#show', as: :task
  get '/tasks/:id/edit', to: 'tasks#edit', as: :edit_task
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'

  patch 'tasks/:id/mark_complete', to: 'tasks#mark_complete', as: :task_complete
  patch 'tasks/:id/mark_incomplete', to: 'tasks#mark_incomplete', as: :task_incomplete
end
