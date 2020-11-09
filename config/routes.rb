Rails.application.routes.draw do
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  root to: "tasks#index"

  # post '/tasks', to: 'tasks#create'
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
