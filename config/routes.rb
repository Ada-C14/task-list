Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, except: [:put]
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
end
