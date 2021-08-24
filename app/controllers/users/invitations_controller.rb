class Users::InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, only: [:update ,:new ,:create]
    
    def new
      super
    end

    def create
      @roles = params[:user][:invited_by_role].downcase!
      # deleting becuse active record raiess StatementInvalid error -> (when sql statement is not correct)
      params[:user].delete :invited_by_role
      
      self.resource = invite_resource
      
      # we will add role here
      self.resource.add_role(@roles)
      self.resource.add_role(@roles ,Board.find_by_id(params[:user][:temp_board_id]))

      resource_invited = resource.errors.empty?

      yield resource if block_given?

      if resource_invited
        
        if is_flashing_format? && self.resource.invitation_sent_at
          set_flash_message :notice, :send_instructions, email: self.resource.email
        end
        
        if self.method(:after_invite_path_for).arity == 1
          respond_with resource, location: after_invite_path_for(current_inviter)
        else
          respond_with resource, location: after_invite_path_for(current_inviter, resource)
        end
      
      else
        respond_with_navigational(resource) { render :new }
        # un comment this for existing user
        # user = User.find_by_email(params[:user][:email])
        # unless user.has_role?(@roles)
        #       user.add_role(@roles)        
        # end

        # user.add_role(@roles ,Board.find_by_id(params[:user][:temp_board_id]))        
        # flash[:notice] = "Email already exists-Permission Updated for that invited user"
        # redirect_to(boards_path)
      end
    end
    
    private
    # This is called when creating invitation.
    # It should return an instance of resource class.
    def invite_resources
      super
    end

    # This is called when accepting invitation.
    # It should return an instance of resource class.
    def accept_resource
        super
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite_key_fields, keys: [:email ])
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username])
    end

end