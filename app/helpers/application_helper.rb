module ApplicationHelper

  def display_dash_in_blank(data)
   data.blank? ? '-' : data
  end

end
