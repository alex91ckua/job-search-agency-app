class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :job_type
      t.string :sector
      t.integer :salary
      t.string :description
      t.string :company_description
      t.string :responsibilities
      t.string :location

      t.timestamps
    end
  end
end
