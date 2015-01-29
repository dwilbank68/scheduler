class Unit < ActiveRecord::Base

  belongs_to :owner
  has_many :unit_users
  has_many :users, :through => :unit_users


  def pos_x
    self.position.split('x').first.to_i
  end

  def pos_y
    self.position.split('x').last.to_i
  end

  def calculated_time_available
    if self.unit_users.count == 0
      data = nil
    else
      data = self.unit_users.last.end_time
    end
    puts "*"*30
    puts "unit_users.count for unit #{self.id} is #{unit_users.count}"
    puts "calculated_time_available is being called and returning " + data.to_s
    puts "*"*30
    data
  end

  def duration_hrs_min
    # "#{self.duration / 60} hrs #{self.duration % 60} min"
    hrsmin = "<span>#{self.duration / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{self.duration % 60}</span><span class='smaller relative raised'>min</span>"
    hrsmin.html_safe
  end

  def unit_users_time_formatted
    new_arr = []
    self.unit_users.each do |uu|
      obj = {}
      obj["id"] = uu.id
      obj["start_time"] = uu.start_time_formatted
      obj["end_time"] = uu.end_time_formatted
      obj["duration"] = uu.duration_hrs_min
      # puts obj.inspect
      new_arr << obj
    end
    new_arr
  end

end
