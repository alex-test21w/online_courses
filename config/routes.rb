Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'welcome#index'

  resources :courses, only: :index

  namespace :users do
    resource :profile, controller: :profile
    resources :courses
  end
end
