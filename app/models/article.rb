class Article < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  # validates :tags, presence: true
  mount_uploader :image, AttachmentUploader
  belongs_to :admin_user
  scope :where_tag, ->(tag) { where('tags ilike ?', "%#{tag}%") }

end
