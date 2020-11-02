Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  get '/error', to: 'tasks#error', as: :error
  resources :tasks, except: [:destroy]
  # # Routes that operate on the task collection
  # get '/tasks', to: 'tasks#index', as: :tasks
  # get '/tasks/new', to: 'tasks#new', as: :new_task
  # post '/tasks', to: 'tasks#create'
  #
  # # Routes that operate on individual books
  # get '/tasks/:id', to: 'tasks#show', as: :task
end


# Rails.application.routes.draw do
#   get    "/books"          , to: "books#index",   as: :book
#   post   "/books"          , to: "books#create"
#   get    "/books/new"      , to: "books#new",     as: :new_book
#   get    "/books/:id"      , to: "books#show",    as: :book
#   patch  "/books/:id"      , to: "books#update"
#   put    "/books/:id"      , to: "books#update"
#   delete "/books/:id"      , to: "books#destroy"
#   get    "/books/:id/edit" , to: "books#edit",    as: :edit_book
# end
