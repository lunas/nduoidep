# override the typus devise auth process
Typus::Authentication::Devise.module_eval do
  def authenticate
    authenticate_user!

    unless current_user.role? :admin
      redirect_to '/', flash: { :error => "Insufficient rights!" }
    end
  end
end