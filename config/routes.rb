Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :courses, only: :index

  namespace :users do
    resources :courses
  end
end
