class AddCompanyRefToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :company, foreign_key: true
  end
end
