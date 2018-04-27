# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = Setting.primary_site_url

if Rails.env.production?
  SitemapGenerator::Sitemap.sitemaps_host = ENV['S3_SITEMAP_HOST']
  SitemapGenerator::Sitemap.public_path = 'tmp/'
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
end

SitemapGenerator::Sitemap.create do

  add articles_path, :priority => 0.7, :changefreq => 'daily'
  add jobs_path, :priority => 1.0, :changefreq => 'weekly'
  add client_services_path, :priority => 1.0, :changefreq => 'yearly'
  add about_us_path, :priority => 0.9, :changefreq => 'yearly'
  add join_us_path, :priority => 0.8, :changefreq => 'yearly'
  add contact_us_path, :priority => 0.8, :changefreq => 'monthly'
  add register_a_vacancy_path, :priority => 0.9, :changefreq => 'yearly'
  add register_interest_path, :priority => 0.9, :changefreq => 'yearly'
  add privacy_policy_path, :priority => 0.5, :changefreq => 'yearly'

  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end

  Job.find_each do |job|
    add job_path(job), :lastmod => job.updated_at
  end

end
