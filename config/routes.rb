Blog::Application.routes.draw do

  resources :pages


  resources :issues


  get "registrations/edit"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
             controllers: {
                 :registrations => "registrations",
                 :confirmations => "confirmations",
                 :passwords => "passwords"
             }

  #devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
  #                   controllers: {:registrations => "registrations"}

  Devise.router_name = :main_app


  root to: 'issues#show'

  #resque_constraint = lambda do |request|
  #  request.env['warden'].authenticate? and request.env['warden'].user.role? :admin
  #end

  #constraints resque_constraint do
  #  mount Resque::Server, :at => "/admin/jobs"
  #end

  namespace :admin do
    resources :users

    resources :issues do
      resources :pages
    end

    resources :companies
  end

  #get :admin, to: "admin/authentications#index"

end
