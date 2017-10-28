Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :scripts, only: %i[new create]
  resource :optimize, only: %i[new create]

  root 'scripts#new'
end
