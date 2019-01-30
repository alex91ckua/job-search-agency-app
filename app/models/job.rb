class Job < ApplicationRecord
  validates :title, presence: true
  # validates :job_function, presence: true
  validates :job_type, presence: true
  validates :sector, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :ref_id, presence: true, uniqueness: true
  validates :salary,
            presence: true,
            numericality:
            {
              only_integer: true,
              greater_than: 0
            },
            if: -> {
              job_type != 'contract'
            }
  validates :day_rate,
            presence: true,
            numericality:
            {
              only_integer: true,
              greater_than: 0
            },
            if: -> {
              job_type == 'contract'
            }

  belongs_to :company, optional: true
  has_many :candidates, dependent: :destroy

  before_validation :remove_whitespaces

  enum sector: [
    'Technology, Media & Telecoms',
    'Retail, FMCG & Hospitality',
    'Private Equity',
    'Infrastructure',
    'Property & Facility Management',
    'Pharmaceuticals & Life Sciences',
    'Mining, Energy & Oil & Gas',
    'Professional Services',
    'Manufacturing'
  ]

  enum job_type: %i[
    permanent_full_time
    permanent_part_time
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
  scope :day_rate_from_to, lambda { |rate_from, rate_to|
    where('day_rate >= ? AND day_rate <= ?', rate_from, rate_to)
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
    # distinct.pluck(:location).map { |l| [l, l] }
    distinct.pluck(:location).map { |l| [l, l] }.sort
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

  def self.day_rate_ranges_options
    [
      ["All", '0-9999999'],
      ["#{Setting.currency_symbol}50-#{Setting.currency_symbol}100", '50-100'],
      ["#{Setting.currency_symbol}100-#{Setting.currency_symbol}300", '100-300'],
      ["#{Setting.currency_symbol}300-#{Setting.currency_symbol}500", '300-500'],
      ["#{Setting.currency_symbol}500-#{Setting.currency_symbol}700", '500-700'],
      ["#{Setting.currency_symbol}700-#{Setting.currency_symbol}1000", '700-1000'],
      ["#{Setting.currency_symbol}1000+", '1000-9999999']
    ]
  end

  private
  def remove_whitespaces
    location.strip!
    title.strip!
  end
end
