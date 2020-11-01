Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tasks#index'

  get '/tasks', to: 'tasks#index', as: 'tasks'  # lists all tasks
  get '/tasks/new', to: 'tasks#new', as: 'new_task'  # Gets a form for a new task
  post 'tasks', to: 'tasks#create'  # create a task

  get '/tasks/:id', to: 'tasks#show', as: 'task'  # shows details for one task
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'  # brings up the form to edit a task
  patch '/tasks/:id', to: 'tasks#update'  # update an existing task
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete_task'  # update an existing task
  delete '/tasks/:id', to: 'tasks#destroy'  # destroy a given task
end
