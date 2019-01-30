class AddDayRateToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :day_rate, :integer
  end
end
