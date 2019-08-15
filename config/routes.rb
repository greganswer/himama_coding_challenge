Rails.application.routes.draw do
  root to: "home#index"
  post '/clock_in', to: 'clock_events#clock_in'
  post '/clock_out', to: 'clock_events#clock_out'
  resources :clock_events, only: %i(index edit destroy)
end
