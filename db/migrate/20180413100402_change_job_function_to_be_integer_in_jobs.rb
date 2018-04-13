class ChangeJobFunctionToBeIntegerInJobs < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :job_function, 'integer USING CAST(job_type AS integer)'
  end
end
