json.extract! article, :id, :title, :description, :tags, :admin_user_id, :created_at, :updated_at
json.url article_url(article, format: :json)
