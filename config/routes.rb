Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  get '/error', to: 'tasks#error', as: :error
  get '/tasks', to: 'tasks#index', as: :tasks
  post '/tasks/new', to: 'tasks#new', as: :new_task
  get '/tasks/:id', to: 'tasks#show', as: :task
end
