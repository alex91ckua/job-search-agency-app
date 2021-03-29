class UpdateTypeInArticles < ActiveRecord::Migration[5.1]
  def change
    Article.unscoped.where(post_type: nil).update_all(post_type: Article.post_types['Post'])
  end
end
