Rails.application.routes.draw do
  root "store#index", as: 'root'
  get '/home', to: "store#index", as: "home"
  get '/api/products.json', to: "store#api_index", as: "api_products"

  get "/auth/signup", to: "auth#get_signup", as: "signup"
  post "/auth/signup", to: "auth#post_signup"
  get "/auth/login", to: "auth#get_login", as: "login"
  post "/auth/login", to: "auth#post_login"
  post "/auth/logout", to: "auth#post_logout", as: "logout"
  post "/api/auth/login", to: "auth#api_login", as: "api_login"

  get "/api/user", to: "user#api_profile", as: "api_profile"

  get '/admin/create', to: "admin#create", as: "create"
  post '/admin/create', to: "admin#post_create"
  get '/admin/edit/:id', to: "admin#edit", as: "edit"
  post '/admin/edit/:id', to: "admin#post_edit"
  get '/admin/delete/:id', to: "admin#delete", as: "delete"
  post '/admin/delete/:id', to: "admin#delete_delete", as: "delete_confirm"
  post '/api/products.json', to: "admin#api_create"

  get "up" => "rails/health#show", as: :rails_health_check
end
