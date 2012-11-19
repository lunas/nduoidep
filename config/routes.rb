Blog::Application.routes.draw do

  resources :pages


  resources :issues


  get "registrations/edit"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {:registrations => "registrations"}
  root to: 'seed#index'

  resources :seed, :only => [:index]

  match :show, to: 'seed#show'  # just an example route to demonstrate cancan's authorization!
  match :edit, to: 'seed#edit'  # just an example route to demonstrate cancan's authorization!


  resque_constraint = lambda do |request|
    request.env['warden'].authenticate? and request.env['warden'].user.role? :admin
  end

  constraints resque_constraint do
    mount Resque::Server, :at => "/admin/jobs"
  end

  namespace :admin do
    resources :users

    resources :issues do
      resources :pages
    end
  end

  #get :admin, to: "admin/authentications#index"

end
