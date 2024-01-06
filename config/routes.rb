Rails.application.routes.draw do
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"
  # quiz model api
namespace :api do
  resources :lessons do
    resources :quizzes, only: [:create], controller: 'quizzes' do
      post 'generate_quiz', on: :member
    end
  end
end
end
