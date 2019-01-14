class RegisterLandingCandidateForm < MailForm::Base
  attribute :first_name, validate: true
  attribute :last_name, validate: true
  attribute :job_function, validate: true
  attribute :phone, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :job_alerts
  attribute :attachment, validate: true, attachment: true
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'Register Candidate Request (from Landing Page) - Global Accounting',
      to: Setting.landing_form_recipients,
      from: %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end