ActiveAdmin.register Office do
  permit_params :name, :phone, :work_time, :address
  menu parent: 'Settings'
end
