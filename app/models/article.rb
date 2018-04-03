class Article < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :tags, presence: true
  belongs_to :admin_user
end
