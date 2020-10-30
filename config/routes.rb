Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  get '/error', to: 'tasks#error', as: :error

  # Routes that operate on the task collection
  get '/tasks', to: 'tasks#index', as: :tasks
  get '/tasks/new', to: 'tasks#new', as: :new_task
  post '/tasks', to: 'tasks#create'

  # Routes that operate on individual books
  get '/tasks/:id', to: 'tasks#show', as: :task
end
