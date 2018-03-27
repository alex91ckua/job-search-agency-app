ActiveAdmin.register Job do
  permit_params :title, :job_type, :sector, :salary, :description, :company_description, :responsibilities, :location

  form do |f|
    inputs do
      f.input :title
      f.input :job_type, as: :select, :include_blank => '-- Please select --'
      f.input :sector
      f.input :salary
      f.input :description, as: :text
      f.input :company_description, as: :text
      f.input :responsibilities, as: :text
      f.input :location
    end
    f.button 'Update Job'
  end
end
