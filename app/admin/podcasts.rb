ActiveAdmin.register Article, as: 'Podcasts' do
  permit_params :title, :subtitle, :description, :tags, :admin_user_id, :image, :created_at, :status

  scope :all, default: true
  scope('Published') { |scope| scope.where(status: Article.statuses['Published']) }
  scope('Draft') { |scope| scope.where(status: Article.statuses['Draft']) }

  action_item only: :show do
    a = controller.find_resource
    link_to 'Preview Podcast', podcast_path(a), target: :_blank
  end

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).last!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
    # override default_scope, remove it
    def scoped_collection
      Article.unscoped.podcasts
    end
  end

  index do
    selectable_column
    column :id
    column :title
    column :subtitle
    column :status
    column :image do |a|
      if a.image.url
        image_tag a.image.url, width: 100
      end
    end
    column :description do |a|
      truncate(strip_tags(a.description), length: 100)
    end
    column :tags
    column :admin_user do |a|
        link_to "#{a.admin_user.first_name} #{a.admin_user.last_name}", admin_admin_user_path(a.admin_user.id)
      end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :subtitle
      row :status
      row :image do |a|
        if a.image.url
          image_tag a.image.url, width: 200
        end
      end
      row :description
      row :tags
      row :admin_user do |a|
        link_to "#{a.admin_user.first_name} #{a.admin_user.last_name}", admin_admin_user_path(a.admin_user.id)
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.object.post_type = Article.post_types['Podcast']
    inputs do
      f.input :title
      f.input :subtitle
      f.input :status
      f.input :image, :as => :file, :hint => f.object.image.present? ? \
                                              image_tag(f.object.image.url, width: 100) : \
                                              content_tag(:span, 'no image selected')
      f.input :description, as: :froala_editor, input_html:
          {
            data: {
              options: {
                height: 300,
                toolbarButtons: ['undo', 'redo', '|', 'bold', 'italic',
                                 'underline', 'strikeThrough', 'subscript',
                                 'superscript', 'outdent', 'indent',
                                 'clearFormatting', 'insertTable', 'html',
                                 'buzzsprout_podcast_providers_button',
                                 'youtube_video_button', 'buzzsprout_podcast_button']
              }
            }
          }
      f.input :tags
      f.input :created_at
      f.input :admin_user_id, as: :select, :collection => Hash[AdminUser.all.map{|u| ["#{u.first_name} #{u.last_name}",u.id]}]
    end
    f.actions
  end
end
