Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index]
  
  post '/script' => 'home#script', as: :script
  post '/run' => 'home#url', as: :url

  root 'home#index'
end
