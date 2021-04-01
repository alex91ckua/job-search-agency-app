module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-warning"
      when 'alert' then "alert alert-error"
    end
  end

  def format_tel_number(phone)
    phone.blank? ? '' : phone.gsub(/[^\w\s]/, '')
  end

  def google_static_map_url(address)
    require 'cgi'
    if address.blank?
      ''
    else
      'https://maps.googleapis.com/maps/api/staticmap?'\
      "center=#{CGI.escape(address)}&zoom=14&scale=2&size=640x600"\
      '&maptype=roadmap&format=png&visual_refresh=true'\
      '&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C'\
      "#{CGI.escape(address)}&key=#{Setting.google_static_maps_key}"
    end
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

  def process_html_shortcodes(html)
    html = html.gsub('[buzzsprout_podcast_providers]', %{
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

    youtube_shortcode_regex = /\[youtube_video id=&quot;(.*?)&quot;\]/

    loop do
      break if youtube_shortcode_regex.match(html).nil?

      youtube_id = youtube_shortcode_regex.match(html)[1]
      replace_str = "[youtube_video id=&quot;#{youtube_id}&quot;\]"

      html = html.gsub(replace_str, %(
        <iframe width="100%" height="400"
          src="https://www.youtube.com/embed/#{youtube_id}"
          title="YouTube video player" frameborder="0"
          allowfullscreen=""></iframe>
        )
      )
    end

    buzzsprout_shortcode_regex = /\[buzzsprout_podcast src=&quot;(.*?)&quot;\]/

    loop do
      break if buzzsprout_shortcode_regex.match(html).nil?

      buzzsprout_src = buzzsprout_shortcode_regex.match(html)[1]
      random_id = rand(100)

      replace_str = "[buzzsprout_podcast src=&quot;#{buzzsprout_src}&quot;\]"

      html = html.gsub(replace_str, %(
        <div id="buzzsprout-player-#{random_id}"></div>
        <script src="https://www.buzzsprout.com#{buzzsprout_src}.js?container_id=buzzsprout-player-#{random_id}&amp;player=small" type="text/javascript" charset="utf-8"></script>
        )
      )
    end

    html
  end
end
