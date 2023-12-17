# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  root 'pages#home'
  get 'users', to: redirect('users/sign_up')
end
