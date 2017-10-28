Rails.application.routes.draw do
  resources :delivery_orders, path: '/orders'
end
