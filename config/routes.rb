Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope ":driver_id" do
    resources :orders, only: [:index, :create] do
      resources :order_adjustments, only: [:index, :create]
    end
  end
end
