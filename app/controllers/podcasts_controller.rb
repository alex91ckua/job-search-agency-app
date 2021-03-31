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

    @article.description = @article.description.gsub('%buzzsprout_podcast_providers%', %{
      <div>
      <div class="podcast-info__listen">
        <a class="listen__item listen__item--apple" target="_blank" href="https://podcasts.apple.com/us/podcast/business-life-hacks/id1509870238?uo=4">Apple Podcasts</a>
        <a class="listen__item listen__item--spotify" target="_blank" href="https://open.spotify.com/show/52bwGDjjU5odHDY4qePNBr">Spotify</a>
        <a class="listen__item listen__item--google" target="_blank" href="https://podcasts.google.com/?feed=aHR0cHM6Ly9mZWVkcy5idXp6c3Byb3V0LmNvbS8xMDgxMjUwLnJzcw==">Google Podcasts</a>
        <a class="listen__item--more" href="#" onclick="jQuery(this).parent().parent().find('.more-providers').toggleClass('d-none'); return false;">More</a>
      </div>

      <div class="modal-takeover more-providers d-none">
        <div class="listen-modal">
          <h3 class="listen-modal--title">Listen to this podcast on</h3>
          <div class="listen-modal__list" data-target="listing.iconList">
            <a class="listen-modal__item--apple" target="_blank" href="https://podcasts.apple.com/us/podcast/business-life-hacks/id1509870238?uo=4">Apple Podcasts</a>
            <a class="listen-modal__item--spotify" target="_blank" href="https://open.spotify.com/show/52bwGDjjU5odHDY4qePNBr">Spotify</a>
            <a class="listen-modal__item--google" target="_blank" href="https://podcasts.google.com/?feed=aHR0cHM6Ly9mZWVkcy5idXp6c3Byb3V0LmNvbS8xMDgxMjUwLnJzcw==">Google Podcasts</a>
            <a class="listen-modal__item--overcast" target="_blank" href="https://overcast.fm/itunes1509870238">Overcast</a>
            <a class="listen-modal__item--stitcher" target="_blank" href="https://www.stitcher.com/podcast/business-life-hacks">Stitcher</a>
            <a class="listen-modal__item--iheartradio" target="_blank" href="https://www.iheart.com/podcast/269-business-life-hacks-63078167/">iHeart Radio</a>
            <a class="listen-modal__item--pandora" target="_blank" href="https://www.pandora.com/podcast/business-life-hacks/PC:33019">Pandora</a>
            <a class="listen-modal__item--tunein" target="_blank" href="https://tunein.com/podcasts/Business--Economics-Podcasts/Business-Life-Hacks-p1324858/">TuneIn + Alexa</a>
            <a class="listen-modal__item--podcastaddict" target="_blank" href="https://podplayer.net/?podId=2923282">Podcast Addict</a>
            <a class="listen-modal__item--castro" target="_blank" href="https://castro.fm/itunes/1509870238">Castro</a>
            <a class="listen-modal__item--castbox" target="_blank" href="https://castbox.fm/vic/1509870238?ref=buzzsprout">Castbox</a>
            <a class="listen-modal__item--podchaser" target="_blank" href="https://www.podchaser.com/podcasts/business-life-hacks-1197888">Podchaser</a>
            <a class="listen-modal__item--pocketcasts" target="_blank" href="https://pca.st/itunes/1509870238">Pocket Casts</a>
            <a class="listen-modal__item--deezer" target="_blank" href="https://www.deezer.com/show/1233392">Deezer</a>
            <a class="listen-modal__item--listennotes" target="_blank" href="https://www.listennotes.com/c/2adbaa0b258144d085d711e8db0474c0/">Listen Notes</a>
            <a class="listen-modal__item--playerfm" target="_blank" href="https://player.fm/series/series-2824339">Player FM</a>
            <a class="listen-modal__item--podcastindex" target="_blank" href="https://podcastindex.org/podcast/369084">Podcast Index</a>
            <a class="listen-modal__item--podfriend" target="_blank" href="https://web.podfriend.com/podcast/1509870238">Podfriend</a>
            <a class="listen-modal__item--rss" target="_blank" href="https://feeds.buzzsprout.com/1081250.rss">RSS Feed</a>
          </div>
        </div>
      </div>
      </div>
    })

    if current_admin_user.nil? && @article.status == 'Draft'
      redirect_to root_path
    end
  end

  private

  # def article_params
  #   params.require(:article).permit(:title, :description, :tags, :admin_user_id)
  # end
end
