class ApplicationMailer < ActionMailer::Base
  default from: 'Trello <No reply>@board.com'
  layout 'mailer'
end
