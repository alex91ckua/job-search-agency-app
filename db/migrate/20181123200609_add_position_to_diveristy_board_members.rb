class AddPositionToDiveristyBoardMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :diversity_board_members, :position, :integer
  end
end
