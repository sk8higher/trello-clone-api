# frozen_string_literal: true

Rails.application.routes.draw do
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
    resources :columns, except: [:new, :edit] do
      resources :cards, except: [:new, :edit] do
        resources :comments, except: [:new, :edit]
      end
    end
  end
end
