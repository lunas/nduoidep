class SeedController < ApplicationController

  # Authorizes each method of this controller according to the abilities defined in Ability.rb,
  # even there's no resource related to this controller.
  # For controllers of actual resources (like User, Article, ...) use: load_and_authorize_resource
  authorize_resource class: false

  def index
    flash[:notice] = "Welcome to the Concrete Interactive Seed application."
  end

  def show
    flash[:notice] = "Show method of SeedController"
  end

  def show
    flash[:notice] = "Edit method of SeedController"
  end
end
