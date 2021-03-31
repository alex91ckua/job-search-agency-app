class Article < ApplicationRecord
  default_scope { where(status: 0) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  after_save :set_status
  after_save :set_post_type

  validates :title, presence: true
  validates :description, presence: true
  # validates :tags, presence: true
  mount_uploader :image, ArticleAttachmentUploader
  belongs_to :admin_user
  scope :where_tag, ->(tag) { where('tags ilike ?', "%#{tag}%") }
  scope :podcasts, ->() { where(post_type: Article.post_types['Podcast']) }
  scope :posts, ->() { where(post_type: Article.post_types['Post']) }

  enum status: %w[Published Draft]

  enum post_type: %w[Post Podcast]

  def should_generate_new_friendly_id?
    title_changed? || new_record? || slug.blank?
  end

  def set_status
    unless self.status
      self.status = Article.statuses['Published']
      save
    end
  end

  def set_post_type
    unless self.post_type
      self.post_type = Article.post_types['Post']
      save
    end
  end

  def set_status
    unless self.status
      self.status = Article.statuses['Published']
      save
    end
  end

end
