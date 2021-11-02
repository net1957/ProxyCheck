Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :scripts, only: %i[new create]
  resource :optimize, only: %i[new create]

  # to respond to health checks.
  get '/health', to: 'health#index'

  root 'scripts#new'
end
