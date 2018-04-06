module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-warning"
      when 'alert' then "alert alert-error"
    end
  end

  def format_tel_number(phone)
    phone.blank? ? '' : phone.gsub(/[^\w\s]/, '')
  end

  def google_static_map_url(address)
    require 'cgi'
    address.blank? ? '' : "https://maps.googleapis.com/maps/api/staticmap?center=#{CGI.escape(address)}&zoom=14&scale=2&size=640x600&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C#{CGI.escape(address)}&key=#{Setting.google_static_maps_key}"
  end
end
