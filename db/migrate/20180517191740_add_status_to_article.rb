class AddStatusToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :status, :integer
  end
end
