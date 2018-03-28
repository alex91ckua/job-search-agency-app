class Candidate < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  belongs_to :job
  mount_uploader :attachment, AttachmentUploader
end
