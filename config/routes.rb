Rails.application.routes.draw do
  resources :lists

  get "/sign_up" => "users#sign_up"
  post '/sign_in' => 'users#authenticate'
  get "/sign_in" => "users#sign_in"
  get "/sign_out" => "users#sign_out"
  post '/sign_up' => 'users#create'
  get '/auth/:provider/callback' => 'users#google_callback'
  root 'lists#index'
  get '/search' => 'lists#search'
  resources :users, only: [:index] do	
  	get '/list' => 'users#user_list'
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end