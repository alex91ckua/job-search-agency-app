ActiveAdmin.register DiversityBoardMember do
permit_params :name, :image
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
    actions
  end

  form do |f|
    inputs do
      f.input :name
      f.input :image, :as => :file, :hint => f.object.image.present? ? \
                                                image_tag(f.object.image.url, width: 100) : \
                                                content_tag(:span, 'no image selected')
    end
    f.actions
  end
end
