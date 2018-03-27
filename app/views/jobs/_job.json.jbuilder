json.extract! job, :id, :title, :job_type, :sector, :salary, :description, :company_description, :responsibilities, :location, :created_at, :updated_at
json.url job_url(job, format: :json)
