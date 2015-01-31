module ApplicationHelper

  def min_to_hrs_min(min)
    hrsmin = "<span>#{min / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{min % 60}</span><span class='smaller relative raised'>min</span>"
    hrsmin.html_safe
  end

  def formatted_phone(number) #US Numbers only, for now
    digits = number.gsub(/\D/, '') if number #.split(//)
    "#{digits[0]} (#{digits[1,3]}) #{digits[4,3]}-#{digits[7,4]}" if digits # % [ digits[0,3], digits[3,3], digits[6,4] ]
  end

end
