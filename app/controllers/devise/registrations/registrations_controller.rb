class Devise::Registrations::RegistrationsController < Devise::RegistrationsController
  private

  def after_sign_up_path_for(resource)
    new_user_confirmation_path if is_navigational_format?
  end
end
