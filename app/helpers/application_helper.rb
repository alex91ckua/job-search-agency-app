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
end
