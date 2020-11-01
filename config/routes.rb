Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'

  root 'tasks#index'
  resources :tasks

  patch 'tasks/:id/mark_complete', to: 'tasks#mark_complete', as: :task_complete
  patch 'tasks/:id/mark_incomplete', to: 'tasks#mark_incomplete', as: :task_incomplete
end
