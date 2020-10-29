Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  root to: 'tasks#index' 
  #get '/tasks', to: 'tasks#index', as: 'tasks' # list all tasks
  #get '/tasks/new', to: 'tasks#new', as: 'new_task' # gets form for new task
  #get '/tasks/:id', to: 'tasks#show', as: 'task' # show details for one task
  #get '/tasks/new', to: 'tasks#new', as: 'new_task' # SHOULD GO BEFORE ID, EXAMPLE OF HOW ORDER MATTERS
  #post '/tasks', to: 'tasks#create' # create a task
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # brings up form to edit a task
  # patch '/tasks/:id', to: 'tasks#update' # update an existing task
  # delete '/tasks/:id', to: 'tasks#destroy' # destroy a given task

end
