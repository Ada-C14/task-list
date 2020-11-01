Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #routes related to collection of tasks
  root to: 'tasks#index'
  resources :tasks

  # #Routes that operate on the book collection
  # get '/tasks', to: 'tasks#index', as: 'tasks' #lists all tasks
  # get 'tasks/new', to: 'tasks#new', as: 'new_task' #Gets a form for a new task
  # post '/tasks', to: 'tasks#create'
  #
  # #routes that deal with a specific task
  # get '/tasks/:id', to: 'tasks#show', as: 'task' #shows details for one task
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' #brings up form to edit task
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'

end
