Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

  resources :projects
end
