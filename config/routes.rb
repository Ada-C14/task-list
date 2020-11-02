Rails.application.routes.draw do

  patch '/tasks/:id/toggle', to: 'tasks#toggle_complete', as: 'toggle_task'
  root to: 'tasks#index'
  resources :tasks

end
