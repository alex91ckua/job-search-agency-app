class RegisterVacancyForm < MailForm::Base
  attribute :first_name, validate: true
  attribute :last_name, validate: true
  attribute :phone, validate: true
  attribute :company_name, validate: true
  attribute :role, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :attachment, attachment: true, validate: :file_type_allowed?
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'Register Vacancy request - Global Accounting',
      to: Setting.email,
      from: %("#{first_name} #{last_name}" <#{email}>)
    }
  end

  def file_type_allowed?
    if attachment.nil?
      self.errors.add(:attachment, "can't be blank")
      return
    end
    acceptable_types = [
      'application/pdf',
      'application/vnd.ms-excel',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/msword',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'text/plain'
    ]
    unless acceptable_types.include? attachment.content_type.chomp
      self.errors.add(:attachment, "with type PDF, EXCEL, WORD or TEXT files are allowed.")
    end
  end
end