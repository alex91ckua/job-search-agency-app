class DiversityBoardMember < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true
  mount_uploader :image, AttachmentUploader
  acts_as_list
end
