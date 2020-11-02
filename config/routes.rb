Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Put most specific lines first

  root to: 'tasks#index'

  get '/tasks', to: 'tasks#index', as: 'tasks' # Lists all books
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # Gets a form for new task
  post '/tasks', to: 'tasks#create'


  get '/tasks/:id', to: 'tasks#show', as: 'show_task' # Show single task
end
