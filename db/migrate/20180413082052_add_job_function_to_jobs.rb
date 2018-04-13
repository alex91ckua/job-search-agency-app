class AddJobFunctionToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :job_function, :string
  end
end
