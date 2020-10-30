Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # verb 'path', to: 'controller#action'
  root :to => "tasks#index"

  # Add routes that have to do with the collection of tasks
  get '/tasks', to: 'tasks#index', as: 'tasks' # lists all books
  get 'tasks/new', to: 'tasks#new', as: 'new_task' # gets a form for a new task
  post '/tasks', to: 'tasks#create'

  # Routes that deal with a specific task
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # brings up the form to edit a task
  patch '/tasks/:id', to: 'tasks#update' # save the new task?
  delete '/tasks/:id', to: 'tasks#destroy' # delete a task
end
