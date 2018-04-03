class ArticlesController < InheritedResources::Base

  def index
    @articles = Article.all
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :tags, :admin_user_id)
    end
end

