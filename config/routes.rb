Blog::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root to: 'seed#index'

  match :show, to: 'seed#show'  # just an example route to demonstrate cancan's authorization!
  match :edit, to: 'seed#edit'  # just an example route to demonstrate cancan's authorization!
end
