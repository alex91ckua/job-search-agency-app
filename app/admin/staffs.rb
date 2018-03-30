ActiveAdmin.register Staff do
permit_params :name, :image, :description
menu parent: 'Settings'
end
