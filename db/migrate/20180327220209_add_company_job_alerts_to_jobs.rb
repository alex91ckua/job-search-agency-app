class AddCompanyJobAlertsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :company_job_alerts, :boolean, default: false
  end
end
