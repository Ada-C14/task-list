Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  root to: 'tasks#index'
  get "/tasks", to: "tasks#index", as: 'tasks'

  # show each task
  get "/tasks/:id", to: 'tasks#show', as: 'task'

  # i feel like i have to do with for wave 2, but I'm also confused
  # like why is this get and not post?
  # get "/tasks", to: 'tasks#new', as: 'task'
end
