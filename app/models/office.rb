class Office < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :work_time, presence: true
  validates :address, presence: true
end
