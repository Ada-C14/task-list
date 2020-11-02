Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action', as: 'path_nickname'

  root to: 'tasks#index'

  resources :tasks

  patch 'tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'


end
