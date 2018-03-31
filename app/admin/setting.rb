# frozen_string_literal: true

ActiveAdmin.register_page 'Site Settings' do
  title = 'Settings'
  menu label: title
  active_admin_settings_page(title: title)
  menu parent: 'Settings'
end
