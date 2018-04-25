class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :description, presence: true
  # validates :tags, presence: true
  mount_uploader :image, AttachmentUploader
  belongs_to :admin_user
  scope :where_tag, ->(tag) { where('tags ilike ?', "%#{tag}%") }

  def should_generate_new_friendly_id?
    title_changed?
  end
end
