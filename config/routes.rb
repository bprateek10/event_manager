Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get ':user_id/user_availability', to: 'home#user_availability'
  get '/events', to: 'home#events'

end
