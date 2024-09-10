class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.development.mailer[:SMTP_USERNAME]
  layout "mailer"
end
