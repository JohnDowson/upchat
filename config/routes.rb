Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :chats, only: %i[ show create ]
  resources :messages, only: %i[ create ]

  resources :users, only: %i[index show] do
    get "chat", to: "chats#get_or_create"
  end

  # Defines the root path route ("/")
  root "users#home"
end
