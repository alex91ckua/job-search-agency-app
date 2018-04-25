class AddRefIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :ref_id, :string
  end
end
