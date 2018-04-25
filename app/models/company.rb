class Company < ApplicationRecord
  validates :name, presence: true
  # validates :email, presence: true, format: { with: Devise.email_regexp }
  # validates :phone, presence: true
end
