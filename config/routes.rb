Rails.application.routes.draw do
  match '/webhooks/event' => 'corona_diff#event', via: [:get, :post]
  get '/', to: 'corona_diff#index'
  post '/recipient/new', to: 'corona_diff#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
