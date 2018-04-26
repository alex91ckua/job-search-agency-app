ActiveAdmin.register Staff do
permit_params :name, :image, :description
menu parent: 'Settings'

config.sort_order = 'position_asc' # assuming Widget.insert_at modifies the `position` attribute
config.paginate   = false
reorderable

  # Reorderable Index Table
  index as: :reorderable_table do
    selectable_column
    column :id
    column :name
    column :image do |a|
      if a.image.url
        image_tag a.image.url, width: 100
      end
    end
    column :description do |staff|
      truncate(strip_tags(staff.description), length: 100)
    end
    actions
  end

  form do |f|
    inputs do
      f.input :name
      f.input :image, :as => :file, :hint => f.object.image.present? ? \
                                                image_tag(f.object.image.url, width: 100) : \
                                                content_tag(:span, 'no image selected')
      f.input :description, as: :froala_editor, input_html:
          {
              data: {
                  options: {
                      height: 300
                  }
              }
          }
    end
    f.actions
  end
end
