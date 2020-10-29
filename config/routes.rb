Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  # get '/tasks', to: 'tasks#index'
  root to: "tasks#index"
  resources :tasks
  # root to: 'tasks#index'
  #
  # # Routes that operate on the task collection
  # get '/tasks/new', to: 'tasks#new', as: :new_task
  # post '/tasks', to: 'tasks#create'
  #
  # # Routes that operate on individual tasks
  # get '/tasks/:id', to: 'tasks#show', as: :task
  # get '/tasks/:id/edit', to: 'tasks#edit', as: :edit_task
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
  #
  #
  # # get    "/books"          , to: "books#index",   as: :book
  # # post   "/books"          , to: "books#create"
  # # get    "/books/new"      , to: "books#new",     as: :new_book
  # # get    "/books/:id"      , to: "books#show",    as: :book
  # # patch  "/books/:id"      , to: "books#update"
  # # put    "/books/:id"      , to: "books#update"
  # # delete "/books/:id"      , to: "books#destroy"
  # # get    "/books/:id/edit" , to: "books#edit",    as: :edit_book
end
