module ApplicationHelper

  def min_to_hrs_min(min)
    hrsmin = "<span>#{min / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{min % 60}</span><span class='smaller relative raised'>min</span>"
    hrsmin.html_safe
  end

end
