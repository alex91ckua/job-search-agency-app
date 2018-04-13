ActiveAdmin.register Job do
  permit_params :title, :job_type, :sector, :salary, :description, :company_id,
                :responsibilities, :location, :company_job_alerts, :job_function

  index do
    column :id
    column :ref_id
    column :title
    column :job_type
    column :job_function
    column :sector
    column :salary
    column :description
    column :company
    column :responsibilities
    column :location
    column :company_job_alerts
    actions
  end

  show do
    attributes_table do
      row :id
      row :ref_id
      row :title
      row :job_type
      row :job_function
      row :sector
      row :salary
      row :description
      row :company
      row :responsibilities
      row :location
      row :company_job_alerts
    end
    active_admin_comments
  end

  sidebar 'Latest Applications', only: :show do
    table_for job.candidates.order(created_at: :desc).limit(15) do
      column :id do |job|
        link_to(job.id, admin_candidate_path(job.id))
      end
      column :first_name
      column :last_name
      column :created_at, sortable: true
    end
  end

  form do |f|
    inputs do
      f.input :title
      f.input :job_type, as: :select, include_blank: '-- Please select --'
      f.input :job_function, as: :select, include_blank: '-- Please select --'
      f.input :sector
      f.input :salary
      f.input :description, as: :text
      f.input :company, as: :select, include_blank: '-- Please select --'
      f.input :responsibilities, as: :text
      f.input :location
      f.input :company_job_alerts
    end
    f.actions
  end
end
