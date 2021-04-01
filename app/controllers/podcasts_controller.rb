# frozen_string_literal: true

class PodcastsController < InheritedResources::Base
  def index
    set_meta_tags title: 'Listen to our Podcasts | Finance Recruiting Agency News',
                  description: 'Read content from one of the most respected
                                boutique search and recruitment firms in the UK.
                                Our blog contains thought provoking insights
                                from our recruitment experts. We cover a wide
                                range of topics including productivity, critical
                                business skills, and global career trends.',
                  og: { title: 'Listen to Our Podcasts | Finance Recruiting Agency News' }

    @articles = Article.podcasts.order(created_at: :desc)
    if params[:order_by_tag].present?
      @articles = @articles.where_tag(params[:order_by_tag])
    end
    tags = Article.podcasts.pluck(:tags)
    @striped_tags = []
    tags.each { |t| t ? t.split(',').each { |tag| @striped_tags.push tag.strip } : '' }
    @striped_tags = @striped_tags.uniq # remove duplicates
  end

  def show
    @article = Article.unscoped.friendly.find(params[:id])
    image_url = @article.image.url || nil
    set_meta_tags title: @article.title,
                  description: '',
                  og: {
                    title: @article.title,
                    image: image_url
                  }

    @article.description = helpers.process_html_shortcodes(@article.description)

    if current_admin_user.nil? && @article.status == 'Draft'
      redirect_to root_path
    end
  end

  private

  # def article_params
  #   params.require(:article).permit(:title, :description, :tags, :admin_user_id)
  # end
end
