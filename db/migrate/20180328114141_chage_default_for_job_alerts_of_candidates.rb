class ChageDefaultForJobAlertsOfCandidates < ActiveRecord::Migration[5.1]
  def up
    change_column :candidates, :job_alerts, :boolean, default: false
  end

  def down
    change_column :candidates, :job_alerts, :boolean, default: nil
  end
end
