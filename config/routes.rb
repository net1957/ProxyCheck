Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :scripts, only: %i[new create]
  get '/scripts', to: 'scripts#new'

  resource :optimize, only: %i[new create]
  get '/optimize', to: 'optimize#new'

  # to respond to health checks.
  get '/health', to: 'health#index'

  root 'scripts#new'
end
