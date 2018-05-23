class RegisterCandidateForm < MailForm::Base
  attribute :first_name, validate: true
  attribute :last_name, validate: true
  attribute :phone, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :job_alerts
  attribute :attachment, validate: true, attachment: true
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'Register Candidate Request - Global Accounting',
      to: Setting.email,
      from: %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end