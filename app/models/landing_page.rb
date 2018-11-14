class LandingPage < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true

  def should_generate_new_friendly_id?
    title_changed? || new_record? || slug.blank?
  end
end
