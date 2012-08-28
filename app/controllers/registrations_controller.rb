class RegistrationsController < Devise::RegistrationsController

  def edit
    authorize! :update, @user
    super
  end

end
