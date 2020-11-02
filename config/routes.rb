Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks

  patch '/tasks/:id/mark', to: 'tasks#mark_complete', as: 'mark_task'
  patch '/tasks/:id/inc', to: 'tasks#mark_incomplete', as: 'mark_incomplete'
end