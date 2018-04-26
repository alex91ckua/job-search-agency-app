class AddPositionToStaff < ActiveRecord::Migration[5.1]
  def change
    add_column :staffs, :position, :integer
  end
end
