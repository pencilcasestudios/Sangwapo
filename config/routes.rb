Sangwapo::Application.routes.draw do
  get "welcome/about"
  get "welcome/contact"
  get "welcome/index"
  get "welcome/privacy"
  get "welcome/terms"




  root :to => "welcome#index"
end
