Rails.application.routes.draw do
  # user and authentication related routes start
  resources :users, only: %w(index show update create) do
    collection do
      get 'logged_in'
      post 'sign_in' => 'users#user_signin'
      post 'change_password'
      post 'forgot_password'
      get 'resend_confirmation'
    end
  end

  devise_for :users, path: 'auth', controllers: {
                       confirmations: 'users/confirmations',
                       passwords: 'users/passwords',
                       registrations: 'users/registrations',
                       sessions: 'users/sessions',
                   }
  #For setting routes devise_scope must be used
  devise_scope :user do
    get 'sign_out' => 'users/sessions#destroy'
    get 'sign_in' => 'home#index'
    # get 'sign_up' => 'users/registrations#new'
  end

  # You can have the root of your site routed with "root"
  root 'home#index'

  # capturing all ember routes below
  get '/home(/*whatever)' => 'home#index'
end
