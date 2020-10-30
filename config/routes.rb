Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #verb 'path', to: 'controller#action'
  root to: 'tasks#index'

  # Routes that have to do with the collection of tasks
  get '/tasks', to: 'tasks#index', as: 'tasks' # Lists all books
  post '/tasks', to: 'tasks#create'
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # Gets a form for a new task


  # Routes that deal with a specific task
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # Brings up a form ratio edit the task
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'

  patch '/tasks/:id/mark_done', to: 'tasks#mark_done', as: 'task_done'

end
