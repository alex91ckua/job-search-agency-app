class Article < ApplicationRecord
  default_scope { where(status: 0) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  after_save :set_status

  validates :title, presence: true
  validates :description, presence: true
  # validates :tags, presence: true
  mount_uploader :image, AttachmentUploader
  belongs_to :admin_user
  scope :where_tag, ->(tag) { where('tags ilike ?', "%#{tag}%") }

  enum status: %w[Published Draft]


  def should_generate_new_friendly_id?
    title_changed? || new_record? || slug.blank?
  end

  def set_status
    unless self.status
      self.status = Article.statuses['Published']
      save
    end
  end
end
