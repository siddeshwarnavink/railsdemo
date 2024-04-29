Rails.application.routes.draw do
  root "store#index", as: 'root'
  get '/home', to: "store#index", as: "home"

  get "/auth/signup", to: "auth#get_signup", as: "signup"
  post "/auth/signup", to: "auth#post_signup"
  get "/auth/login", to: "auth#get_login" , as: "login"
  post "/auth/login", to: "auth#post_login"
  post "/auth/logout", to: "auth#post_logout", as: "logout"

  get '/admin/create', to: "admin#create", as: "create_product"
  post '/admin/create', to: "admin#post_create", as: 'admin_create'

  get "up" => "rails/health#show", as: :rails_health_check
end
