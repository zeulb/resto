Rails.application.routes.draw do
  resources :delivery_orders, path: '/orders' do
    resources :feedbacks
  end
end
