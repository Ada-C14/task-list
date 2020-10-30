Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  # Routes that operate on the task collection
  get "/tasks", to: "tasks#index", as: "tasks" # lists all books
  get "/tasks/new", to: "tasks#new", as: "new_task" # get a form for a new book "from"
  post "/tasks", to: "tasks#create" # same nick name because of the same path/route "to"

  # Routes that operate on individual task
  get "/tasks/:id", to: "tasks#show", as: "task"
  get "/tasks/:id/edit", to: "task#edit", as: "edit_task" # brings up the form to edit a task
  patch "/tasks/:id", to: "tasks#update"
  delete "/tasks/:id", to: "tasks#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # You can have the root of your site routed with "root"
  # get 'tasks/index'
  # When there is no path, will match root.
  root to: "tasks#index"
end
