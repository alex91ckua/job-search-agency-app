ActiveAdmin.register Staff do
permit_params :name, :image, :description
menu parent: 'Settings'

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
