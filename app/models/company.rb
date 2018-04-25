class Company < ApplicationRecord
  validates :name, presence: true
  has_many :jobs, dependent: :nullify
  # validates :email, presence: true, format: { with: Devise.email_regexp }
  # validates :phone, presence: true
end
