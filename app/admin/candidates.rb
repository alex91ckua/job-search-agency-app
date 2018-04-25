ActiveAdmin.register Candidate do
  actions :index, :show, :destroy

  index do
    column :id
    column :first_name
    column :last_name
    column :email
    column :phone
    column :attachment do |candidate|
      if candidate.attachment.file
        link_to(candidate.attachment.file.filename, candidate.attachment.url)
      end
    end
    column :job_alerts
    column :job
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :phone
      row :attachment do |candidate|
        link_to(candidate.attachment.file.filename, candidate.attachment.url) if candidate.attachment.file
      end
      row :job_alerts
      row :job
      row :created_at
    end
    active_admin_comments
  end

end
