class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :phone])
  end
end

# http://localhost:3000/users/invitation/accept?invitation_token=b49f107f8560cce6cc40607f0e09d202f6b6048a86364b5a8d11bd315180aee7