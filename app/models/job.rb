class Job < ApplicationRecord
  enum job_type: [ :full_time, :part_time ]

  scope :salary_from, ->(salary_from) { where('salary >= ?', salary_from) }
  scope :salary_to, ->(salary_to) { where('salary <= ?', salary_to) }
  scope :location, ->(location) { where location: location }
  scope :sector, ->(sector) { where sector: sector }
  scope :job_type, ->(job_type) { where job_type: job_type }
  scope :title, ->(title) { where('title ilike ?', "%#{title}%") }
  scope :ordered_by_title, -> { order(title: :asc) }
  scope :ordered_by_date, -> { order(created_at: :desc) }

  def self.job_types_options
    # or use the I18n module to humanize the keys
    self.job_types.map { |k,v| [k.humanize.capitalize, v] }
  end

  def self.locations_options
    # or use the I18n module to humanize the keys
    self.distinct.pluck(:location).map { |l| [l, l] }
  end

  def self.sectors_options
    # or use the I18n module to humanize the keys
    self.distinct.pluck(:sector).map { |l| [l, l] }
  end

end
