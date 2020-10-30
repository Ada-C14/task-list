Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  # collection of tasks

  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks/', to: 'tasks#create'

  # specific task

  get '/tasks/:id', to: 'tasks#show', as: 'task'
end
