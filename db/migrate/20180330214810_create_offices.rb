class CreateOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :phone
      t.string :work_time
      t.string :address

      t.timestamps
    end
  end
end
