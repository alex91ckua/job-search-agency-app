require 'rubypress'
require 'nokogiri'
require 'date'
# Import the relevant environment
require File.expand_path('config/environments/development.rb')
require 'json'

wordpress = Rubypress::Client.new(
  host: 'globalaccountingnetwork.net',
  username: 'admin',
  password: 'admin',
  retry_timeouts: true
)

# Import blog posts from old website
if Article.count.zero?

  wp_posts = wordpress.getPosts(filter: {
      number: 100,
      orderby: 'post_id',
      post_status: 'publish',
      post_type: 'blog'
  })

  wp_posts.each do |wp_post|
    article = Article.create!(
        title: wp_post['post_title'],
        description: wp_post['post_content'],
        created_at: wp_post['post_date_gmt'].to_date,
        updated_at: wp_post['post_modified'].to_date,
        admin_user: AdminUser.first
    )

    post_content_html = Nokogiri::HTML(wp_post['post_content'])
    if img = post_content_html.xpath('//img').first
      article.remote_image_url = img.attr('src')
      article.save
    end
  end
end

# Import Job posts from old website
if Job.count.zero?

  # Job posts
  wp_jobs = wordpress.getPosts(filter: {
      number: 100,
      orderby: 'post_id',
      post_status: 'publish',
      post_type: 'vacancy'
  })

  wp_jobs.each do |wp_post|
    job = Job.new(
      title: wp_post['post_title'],
      created_at: wp_post['post_date_gmt'].to_date,
      updated_at: wp_post['post_modified'].to_date
    )

    intro_text = ''
    description = wp_post['post_content']
    wp_post['custom_fields'].each do |field|
      if field['key'] == 'sector'
        job.sector = Job.sectors['Technology, Media & Telecoms'] if field['value'] == 'tech'
        job.sector = Job.sectors['Retail, FMCG & Hospitality'] if field['value'] == 'retail'
        job.sector = Job.sectors['Private Equity'] if field['value'] == 'equity'
        job.sector = Job.sectors['Infrastructure & Prof. Services'] if field['value'] == 'infra'
        job.sector = Job.sectors['Property & Facility Management'] if field['value'] == 'property'
        job.sector = Job.sectors['Pharmaceuticals & Life Sciences'] if field['value'] == 'pharma'
        job.sector = Job.sectors['Mining, Energy & Oil & Gas'] if field['value'] == 'mining'
      end

      if field['key'] == 'contract_type'
        job.job_type = 0
        job.job_type = Job.job_types[:permament_full_time] if field['value'] == 'perm'
        job.job_type = Job.job_types[:permament_part_time] if field['value'] == 'permpart'
        job.job_type = Job.job_types[:fixed_term_full_time] if field['value'] == 'fixed'
        job.job_type = Job.job_types[:fixed_term_part_time] if field['value'] == 'fixedpart'
        job.job_type = Job.job_types[:contract] if field['value'] == 'con'
      end

      if field['key'] == 'intro_text'
        intro_text = field['value']
      end

      if field['key'] == 'location'
        job.location = field['value']
      end

      if field['key'] == 'reference'
        job.ref_id = field['value']
      end

      if field['key'] == 'salary_upper'
        job.salary = field['value'].to_i
      end

      if field['key'] == 'salary_upper'
        job.salary = field['value'].to_i
      end

    end

    description = "#{intro_text}#{description}"
    job.description = description
    job.save
  end

end