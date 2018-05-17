class ApplicationMailer < ActionMailer::Base
  default from: Setting.email
  layout 'mailer'
end
