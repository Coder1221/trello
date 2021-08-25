class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_user_invitation.subject
  #
  def new_user_invitation
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
