class ChangeSectorToBeIntegerInJobs < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :sector, 'integer USING CAST(sector AS integer)'
  end
end
