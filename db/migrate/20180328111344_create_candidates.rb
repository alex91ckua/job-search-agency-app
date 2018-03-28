class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :attachment
      t.boolean :job_alerts
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
