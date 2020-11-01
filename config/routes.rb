Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  get '/tasks/show', to: 'tasks#show', as: 'show_task'
  get '/tasks/edit', to: 'tasks#edit', as: 'edit_task'
end