Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks
  patch '/tasks/:id/complete', to: 'tasks#toggle_complete', as: 'complete_task'
  # Add routes that have to do with a collection of books
  # get '/tasks', to: 'tasks#index', as: 'tasks' #lists all tasks
  # get '/tasks/new', to: 'tasks#new', as: 'new_task' #gets a form for a new task
  # post '/tasks', to: 'tasks#create'
  # #Add routes that deal with a specific Task
  #
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' #brings up the form to edit a task
  # get '/tasks/:id', to: 'tasks#show', as: 'task' #shows details for 1 task
  # patch '/tasks/:id', to: 'tasks#update'

end
