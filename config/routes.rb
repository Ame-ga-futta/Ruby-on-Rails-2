Rails.application.routes.draw do
  get "/" => "users#top"
  get "/users/log_in" => "users#login_form"
  post "/users/log_in" => "users#login"
  post "/users/log_out" => "users#logout"
  get "/users/sign_up" => "users#signup_form"
  get "/users/account" => "users#account"
  patch "/users/:id/edit" => "users#update_account"
  get "/users/profile" => "users#profile"
  patch "/users/profile" => "users#update_profile"

  get "/rooms/posts" => "rooms#rooms"
  get "/search-area" => "rooms#search_area"
  get "/search-keyword" => "rooms#search_keyword"

  get "/reservations" => "reservations#reservations"
  post "/rooms/:id" => "reservations#confirm"
  post "/rooms/:id/confirm" => "reservations#create"

  resources :rooms
  resources :users
end
