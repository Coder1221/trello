# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  after_action :job_run, only: [:create]
  # GET /resource/sign_in
  def new
    super
  end
  
  def job_run
    boards = Board.where(user_id: current_user.id)
    global_id_of_boards = []
    boards.each do |board|
      global_id_of_boards << board.to_sgid.to_s
    end    
    ReminderAlertJob.perform_later(global_id_of_boards)
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end