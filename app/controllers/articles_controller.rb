class ArticlesController < InheritedResources::Base

  def index
    @articles = Article.all.order(created_at: :desc)
    @articles = @articles.where_tag(params[:order_by_tag]) if params[:order_by_tag].present?
    tags = Article.pluck(:tags)
    @striped_tags = []
    tags.each { |t| t ? t.split(',').each { |tag| @striped_tags.push tag.strip } : '' }
    @striped_tags = @striped_tags.uniq # remove duplicates
  end

  def show
    @article = Article.friendly.find(params[:id])
    @related_articles = Article.order('RANDOM()').where.not(slug: params[:id]).limit(15)
  end

  private

    # def article_params
    #   params.require(:article).permit(:title, :description, :tags, :admin_user_id)
    # end
end

