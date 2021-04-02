Rails.application.routes.draw do
  if !Rails.env.production?
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  resources :posts
  resources :posts do
  resources :replies
  end
  resources :chatbot_messages
  resources :reminders
  resources :user_plants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints Clearance::Constraints::SignedIn.new do
    get '/', to: 'users#current_user_dashboard'
  end
  
  constraints Clearance::Constraints::SignedOut.new do
    get '/', to: redirect('/sign_in')
  end
  
end
