class SeedController < ApplicationController

  # Authorizes each method of this controller according to the abilities defined in Ability.rb,
  # even there's no resource related to this controller.
  # For controllers of actual resources (like User, Article, ...) use: load_and_authorize_resource
  authorize_resource class: false, except: [:index]

  def index
    welcome = "Welcome to Nguoi Dep."
    flash[:notice] = welcome

    respond_to do |format|
      format.html
      format.json { render_for_api api_template(params), :json => User.all }    # there's a route match '/users' to: 'seed#index'
    end
  end

  def show
    flash[:notice] = "Show method of SeedController"
  end

  def show
    flash[:notice] = "Edit method of SeedController"
  end
end
