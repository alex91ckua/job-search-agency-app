class CallbackForm < MailForm::Base
  attribute :first_name,      :validate => true
  attribute :last_name,      :validate => true
  attribute :request_type,     :validate => ["General", "Propose"]
  attribute :phone,      :validate => true
  attribute :company_name,      :validate => true
  attribute :call_time,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,   :captcha => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'Call me Back request - Global Accounting',
      to: Setting.email,
      from: %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end