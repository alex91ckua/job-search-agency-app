ActiveAdmin.register Article do
  permit_params :title, :subtitle, :description, :tags, :admin_user_id
  menu label: 'Blog'

  index do
    column :id
    column :title
    column :subtitle
    column :description do |a|
      truncate(a.description, length: 100)
    end
    column :tags
    column :admin_user do |a|
        link_to "#{a.admin_user.first_name} #{a.admin_user.last_name}", admin_admin_user_path(a.admin_user.id)
      end
    column :created_at
    actions
  end

  form do |f|
    inputs do
      f.input :title
      f.input :subtitle
      f.input :description, as: :froala_editor, input_html: {data: {options: {height: 300}}}
      f.input :tags
      f.input :admin_user_id, as: :select, :collection => Hash[AdminUser.all.map{|u| ["#{u.first_name} #{u.last_name}",u.id]}]
    end
    f.actions
  end
end
