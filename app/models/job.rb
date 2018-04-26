class Job < ApplicationRecord
  validates :title, presence: true
  # validates :job_function, presence: true
  validates :job_type, presence: true
  validates :sector, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :ref_id, presence: true, uniqueness: true
  validates :salary, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
  belongs_to :company, optional: true
  has_many :candidates

  enum sector: [
    'Technology, Media & Telecoms',
    'Retail, FMCG & Hospitality',
    'Private Equity',
    'Infrastructure & Prof. Services',
    'Property & Facility Management',
    'Pharmaceuticals & Life Sciences',
    'Mining, Energy & Oil & Gas'
  ]

  enum job_type: %i[
    permament_full_time
    permament_part_time
    fixed_term_full_time
    fixed_term_part_time
    contract
  ]
  enum job_function: %i[
    finance_director
    cfo
    financial_controller
    fp&a
    business_partner
    systems_accountant
    finance_transformation
    group_accounting
    financial_accountant
    management_accountant
    finance_manager
    internal_audit
    project_accountant
    commercial_analysis
    financial_analysis
  ]

  scope :salary_from, ->(salary_from) { where('salary >= ?', salary_from) }
  scope :salary_to, ->(salary_to) { where('salary <= ?', salary_to) }
  scope :salary_from_to, lambda { |salary_from, salary_to|
    where('salary >= ? AND salary <= ?', salary_from, salary_to)
  }
  scope :location, ->(location) { where location: location }
  scope :sector, ->(sector) { where sector: sector }
  scope :job_type, ->(job_type) { where job_type: job_type }
  scope :job_function, ->(job_function) { where job_function: job_function }
  scope :title, ->(title) { where('title ilike ?', "%#{title}%") }
  scope :ordered_by_title, -> { order(title: :asc) }
  scope :ordered_by_date, -> { order(created_at: :desc) }

  def self.job_functions_options
    # or use the I18n module to humanize the keys
    job_functions.map { |k, v| [k.humanize.capitalize, v] }
  end

  def self.job_types_options
    job_types.map { |k, v| [k.humanize.capitalize, v] }
  end

  def self.locations_options
    distinct.pluck(:location).map { |l| [l, l] }
  end

  def self.sectors_options
    sectors.map { |k, v| [k.humanize.capitalize, v] }
  end

  def self.salary_ranges_options
    [
        ["#{Setting.currency_symbol}40000-#{Setting.currency_symbol}60000", '40000-60000'],
        ["#{Setting.currency_symbol}60000-#{Setting.currency_symbol}80000", '60000-80000'],
        ["#{Setting.currency_symbol}80000-#{Setting.currency_symbol}100000", '80000-100000'],
        ["#{Setting.currency_symbol}100000-#{Setting.currency_symbol}150000", '100000-150000'],
        ["#{Setting.currency_symbol}150000-#{Setting.currency_symbol}200000", '150000-200000'],
        ["#{Setting.currency_symbol}200000-#{Setting.currency_symbol}250000", '200000-250000'],
        ["#{Setting.currency_symbol}250000-#{Setting.currency_symbol}350000", '250000-350000'],
        ["#{Setting.currency_symbol}350000+", '350000-9999999']
    ]
    # 40000-60000, 60000-80000, 80000-100000, 100000-150000, 150000-200000, 200000-250000, 250000-350000, 350000+
  end

end
