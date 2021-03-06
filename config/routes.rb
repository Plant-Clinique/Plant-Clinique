Rails.application.routes.draw do
  resources :replies
  resources :posts
  resources :chatbot_messages
  resources :reminders
  resources :user_plants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
