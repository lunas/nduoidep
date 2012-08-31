class SeedController < ApplicationController

  # Authorizes each method of this controller according to the abilities defined in Ability.rb,
  # even there's no resource related to this controller.
  # For controllers of actual resources (like User, Article, ...) use: load_and_authorize_resource
  authorize_resource class: false, except: [:index]

  def index
    welcome = "Welcome to the Concrete Interactive Seed application."
    flash[:notice] = welcome
    Resque.enqueue(ResqueExampleTask, welcome)

    respond_to do |format|
      format.html
      format.json { render_for_api :show, :json => User.all }    # there's a route match '/users' to: 'seed#index'
    end
  end

  def show
    flash[:notice] = "Show method of SeedController"
  end

  def show
    flash[:notice] = "Edit method of SeedController"
  end
end
