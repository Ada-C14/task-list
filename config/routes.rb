Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Put most specific lines first

  root to: 'tasks#index'
  # resources :tasks

  get '/tasks', to: 'tasks#index', as: 'tasks' # Lists all books
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # Gets a form for new task
  post '/tasks', to: 'tasks#create'


  get '/tasks/:id', to: 'tasks#show', as: 'task' # Show single task
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # Edit single task
  patch '/tasks/:id', to: 'tasks#update'
  patch '/tasks/:id/toggle', to: 'tasks#toggle', as: 'toggle_task' # Mark single task as complete or incomplete
  delete '/tasks/:id', to: 'tasks#destroy'
  # patch mark_complete_path(:id) to: "tasks#mark_complete"
end
