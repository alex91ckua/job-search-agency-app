class AddTypeToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :post_type, :integer
  end
end
