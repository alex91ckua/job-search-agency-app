class Staff < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true
  validates :description, presence: true
  mount_uploader :image, AttachmentUploader
end
