ActiveAdmin.register LandingPage do
  permit_params :title, :subtitle

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).last!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end

  action_item only: :show do
    a = controller.find_resource
    link_to 'Preview', landing_page_path(a), target: :_blank
  end

  form do |f|
    inputs do
      f.input :title
      f.input :subtitle
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :subtitle
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
