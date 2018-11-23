class CreateDiversityBoardMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :diversity_board_members do |t|
      t.string :name

      t.timestamps
    end
  end
end
