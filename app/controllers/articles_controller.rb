class ArticlesController < InheritedResources::Base

  def index
    @articles = Article.all
    @articles = @articles.where_tag(params[:order_by_tag]) if params[:order_by_tag].present?
    tags = Article.pluck(:tags)
    @striped_tags = []
    tags.each { |t| t.split(',').each { |tag| @striped_tags.push tag.strip } }
  end

  def show
    @article = Article.find(params[:id])
    @related_articles = Article.where.not(id: params[:id]).limit(9)
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :tags, :admin_user_id)
    end
end

