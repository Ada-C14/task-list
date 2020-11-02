Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index', as: 'tasks'
  root to: 'tasks#index'
end
