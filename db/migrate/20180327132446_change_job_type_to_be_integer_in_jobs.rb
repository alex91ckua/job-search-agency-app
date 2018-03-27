class ChangeJobTypeToBeIntegerInJobs < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :job_type, 'integer USING CAST(job_type AS integer)'
  end
end
