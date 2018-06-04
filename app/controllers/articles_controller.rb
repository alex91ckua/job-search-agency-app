class ArticlesController < InheritedResources::Base

  def index
    set_meta_tags title: 'Read Our Blog | Finance Recruiting Agency News',
                  description: 'Read content from one of the most respected boutique search and recruitment firms in the UK. Our blog contains thought provoking insights from our recruitment experts. We cover a wide range of topics including productivity, critical business skills, and global career trends.',
                  og: { title: 'Read Our Blog | Finance Recruiting Agency News' }

    @articles = Article.all.order(created_at: :desc)
    @articles = @articles.where_tag(params[:order_by_tag]) if params[:order_by_tag].present?
    tags = Article.pluck(:tags)
    @striped_tags = []
    tags.each { |t| t ? t.split(',').each { |tag| @striped_tags.push tag.strip } : '' }
    @striped_tags = @striped_tags.uniq # remove duplicates
  end

  def show
    @article = Article.unscoped.friendly.find(params[:id])
    set_meta_tags title: @article.title,
                  description: '',
                  og: { title: @article.title }
    @related_articles = Article.order('RANDOM()').where.not(slug: params[:id]).limit(15)

    if current_admin_user.nil? && @article.status == 'Draft'
      redirect_to root_path
    end
  end

  private

    # def article_params
    #   params.require(:article).permit(:title, :description, :tags, :admin_user_id)
    # end
end

