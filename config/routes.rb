Sangwapo::Application.routes.draw do
  get "welcome/about"
  get "welcome/contact"
  get "welcome/index"
  get "welcome/privacy"
  get "welcome/terms"




  match "about", :to => "welcome#about", :as => "about"
  match "account_settings", :to => "users#edit", :as => "account_settings"
  match "contact", :to => "welcome#contact", :as => "contact"
  match "privacy", :to => "welcome#privacy", :as => "privacy"
  match "sign_in", :to => "sessions#new", :as => "sign_in"
  match "sign_out", :to => "sessions#destroy", :as => "sign_out"
  match "sign_up", :to => "users#new", :as => "sign_up"
  match "terms", :to => "welcome#terms", :as => "terms"




  resources :listings do
    member do
      put :accept
      put :clear
      put :pay
      put :refresh
      put :reject
    end
    
    collection do
      get :mine
      get :review
    end
  end
  
  resources :payments do
    collection do
      get :pending
    end
  end
  
  resources :comments
  resources :sessions
  resources :users




  root :to => "listings#index"
end
