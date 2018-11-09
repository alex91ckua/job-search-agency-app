class CreateLandingPages < ActiveRecord::Migration[5.1]
  def change
    create_table :landing_pages do |t|
      t.string :title
      t.string :subtitle

      t.timestamps
    end
  end
end
