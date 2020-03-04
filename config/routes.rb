Rails.application.routes.draw do
  post '/webhooks/event', to: 'corona_diff#event'
  get '/', to: 'corona_diff#index'
  post '/recipient/new', to: 'corona_diff#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
