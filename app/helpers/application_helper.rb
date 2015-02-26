module ApplicationHelper

  def formatted_phone(number) #US Numbers only, for now
    digits = number.gsub(/\D/, '') if number #.split(//)
    "#{digits[0]} (#{digits[1,3]}) #{digits[4,3]}-#{digits[7,4]}" if digits # % [ digits[0,3], digits[3,3], digits[6,4] ]
  end

  def unit_overlay_classes(unit)
    unit.state == "active" ? "hidden" : ""
  end

  def contact_colors(user)
    {
      :email1_vis => user.contact_flags[0] == "1" ? "gold-glow" : "grayed-out",
      :email1_act => user.contact_flags[1] == "1" ? "gold-glow" : "grayed-out",
      :email2_vis => user.contact_flags[2] == "1" ? "gold-glow" : "grayed-out",
      :email2_act => user.contact_flags[3] == "1" ? "gold-glow" : "grayed-out",
      :phone1_vis => user.contact_flags[4] == "1" ? "gold-glow" : "grayed-out",
      :phone1_act => user.contact_flags[5] == "1" ? "gold-glow" : "grayed-out",
      :phone2_vis => user.contact_flags[6] == "1" ? "gold-glow" : "grayed-out",
      :phone2_act => user.contact_flags[7] == "1" ? "gold-glow" : "grayed-out",
    }
  end

  def blue_outline(unit)
    unit.notes && unit.notes.length > 0 ? " blue-glow-outline" : ""
  end

end
