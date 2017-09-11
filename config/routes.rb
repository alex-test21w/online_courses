Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root 'welcome#index'

  resources :courses, only: [:index, :show] do
    resources :participants, only: :index
    resource  :participant_subscriptions, only: [:create, :destroy], controller: :course_participant_subscriptions
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
    resource  :feed_claims, only: [:create, :destroy], controller: :course_feed_claims
    resource  :expel_participants, only: :create

    resources :lessons, only: [:index, :show], controller: :course_lessons do
      resource :homeworks, only: :create, controller: :lesson_homeworks
    end
  end

  namespace :users do
    resource  :profile, controller: :profile

    resources :courses do
      resources :lessons
    end
  end
end
