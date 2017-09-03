Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root 'welcome#index'

  resources :courses, only: :index do
    resources :participants, only: :index
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
  end

  namespace :users do
    resource  :profile, controller: :profile
    resources :courses
  end
end
