Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tasks#index'

  resources :tasks
  # add routes that have to do with the collection of tasks
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task' # gets a form for a new task
  # post '/tasks', to: 'tasks#create' # don't need to make a nickname
  #
  # # routes that deal with a specific task
  # get '/tasks/:id', to: 'tasks#show', as: 'task' # shows details for 1 task
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # brings up the form to edit a book
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'

  # mark completed custom path
  patch '/tasks/:id/mark_complete', to: "tasks#mark_complete", as: "mark_complete"


end
