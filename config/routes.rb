Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :courses, only: :index
      resources :auth_tokens, only: :create

      namespace :user do
        resources :courses, only: :index
      end
    end
  end

  resources :courses, only: [:index, :show] do
    resources :participants, only: :index
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
    resource  :feed_claims, only: [:create, :destroy], controller: :course_feed_claims
    resource  :expel_participants, only: :create

    resources :lessons, only: [:index, :show], controller: :course_lessons do
      resource :homeworks, only: :create, controller: :lesson_homeworks
    end
  end

  namespace :users do
    resource  :profile, controller: :profile
    resources :activities, only: :index

    resources :courses do
      resources :lessons do
        resources :homeworks, only: [:index, :show, :update]
      end
    end
  end

  scope 'user' do
    resources :homeworks, only: :show
  end
end
