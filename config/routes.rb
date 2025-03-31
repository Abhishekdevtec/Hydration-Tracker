Rails.application.routes.draw do
  devise_for :users

  resources :beverage_entries do
    collection do
      get :subtypes
    end
  end

  resources :beverage_types
  
  resources :symptoms, only: [:index]
  root 'beverage_entries#index'

end
