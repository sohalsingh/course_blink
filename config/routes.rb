Rails.application.routes.draw do
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # service worker & manifest in pwa
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"
  # quiz model api
  namespace :api do
    namespace :v1 do
      post 'lesson_history', to: 'lesson_history#view_lesson'
      post 'submissions', to: 'submissions#create'
    end
    resources :lessons do
      resources :quizzes, only: [:create], controller: 'quizzes' do
        post 'generate_quiz', on: :member
      end
    end
  end

  # Routes
  resources :courses
  post 'courses/:id/enroll', to: 'courses#enroll', as: 'enroll_course'
  post 'courses/:id/unenroll', to: 'courses#unenroll', as: 'unenroll_course'
  get 'courses/:id/lessons', to: 'courses#lessons', as: 'course_lessons'
  get 'courses/:id/lessons/:lesson_id', to: 'courses#lesson_show', as: 'show_course_lesson'
  get 'courses/:id/quizzes/:quiz_id', to: 'courses#quiz_show', as: 'show_course_quiz'
  get 'courses/:id/certificate.pdf', to: 'courses#certificate', as: 'course_certificate'


  get 'verify_certificate/:data', to: 'certificates#verify', as: 'verify_certificate'

  # Search
  resources :search, only: [:index]

end
