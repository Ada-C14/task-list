Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks
  
  # Costomerized actions
  put 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  put 'tasks/:id/uncomplete', to: 'tasks#uncomplete', as: 'uncomplete_task'
end
