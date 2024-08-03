# frozen_string_literal: true

Rails.application.routes.draw do
  get 'columns/show'
  get 'columns/create'
  devise_for :users, path: '', path_names: {
     sign_in: 'login',
     sign_out: 'logout',
     registration: 'signup'
   },
   controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show] do
    resources :columns, only: [:index, :create, :show, :destroy, :update]
  end
end
