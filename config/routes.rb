Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'

  # Routes that operate on tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/:id', to: 'tasks#show'
end
