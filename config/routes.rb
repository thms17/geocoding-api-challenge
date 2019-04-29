Rails.application.routes.draw do
  resources :coordinates, only: [:index]
  get '/coordinates/:query', to: 'coordinates#index', constraints: { query: /[^\/]+/ }
end
