# Preview all emails at http://localhost:3000/rails/mailers/model_mailer
class ModelMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/model_mailer/new_user_invitation
  def new_user_invitation
    ModelMailer.new_user_invitation
  end

end
