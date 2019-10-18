module ApplicationHelper

  def display_dash_in_blank(data)
   data.blank? ? '-' : data
  end

  def build_alert_classes(alert_type)
    case alert_type.to_sym
    when :notice, :success
      ALERT[0]
    when :danger, :error, :alert
      ALERT[1]
    end
  end
end
