Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes that have to do with the collection of tasks
  root to:'tasks#index'
  resources :tasks
  # get '/tasks', to: 'tasks#index', as: 'tasks' # list all tasks
  # get '/tasks/new', to: 'tasks#new', as: 'new_task' # gets a form for a new book
  # post '/tasks', to: 'tasks#create' # dont need a name / create a book
  #
  #
  # # Routes that deal with a specific Task
  # get '/tasks/:id', to: 'tasks#show', as: 'task' # shows details for 1 task
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # brings up the form to edite a task
  # patch '/tasks/:id', to: 'tasks#update' # Update an existing task
  # delete '/tasks/:id', to: 'tasks#destroy' # Destroy a given task
  #
  # custom route
  patch '/tasks/:id/complete', to: 'tasks#mark_complete', as: 'mark_complete'

end
