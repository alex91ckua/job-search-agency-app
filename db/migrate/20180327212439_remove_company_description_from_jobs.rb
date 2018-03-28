class RemoveCompanyDescriptionFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :company_description, :string
  end
end
