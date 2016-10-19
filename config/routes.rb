Rails.application.routes.draw do
  root to: "members#index"
  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
