class Users::InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, only: [:update]

    
    private
    # This is called when creating invitation.
    # It should return an instance of resource class.
    
    def invite_resource
      super
    end

    # This is called when accepting invitation.
    # It should return an instance of resource class.
    
    def accept_resource
        super
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username])
    end
  
end