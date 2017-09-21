require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root 'welcome#index'

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :courses, only: :index
      resource  :auth_tokens, only: :create
      resource  :auth_users, only: :create

      namespace :user do
        resources :courses, only: :index
        resource  :course_subscriptions, only: :create
      end
    end
  end

  resources :courses, only: %i[index show] do
    resources :participants, only: :index
    resource  :subscriptions, only: %i[create destroy], controller: :course_subscriptions
    resource  :feed_claims, only: %i[create destroy], controller: :course_feed_claims
    resource  :expel_participants, only: :create

    resources :lessons, only: %i[index show], controller: :course_lessons do
      resource :homeworks, only: :create, controller: :lesson_homeworks
    end
  end

  resources :lessons, controller: :course_lessons, only: [] do
    resources :comments, only: %i[create destroy]
  end

  resources :homeworks, controller: :lesson_homeworks, only: [] do
    resources :comments, only: %i[create destroy]
  end

  namespace :users do
    resource  :profile, controller: :profile
    resources :activities, only: :index

    resources :courses do
      resources :lessons do
        resources :homeworks, only: %i[index update]
      end
    end
  end

  scope 'user' do
    resources :homeworks, only: %i[index show]
  end
end
