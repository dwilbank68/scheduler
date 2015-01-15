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

  def time_available
    # @unit = self.unit
    if unit_users.length == 0
      return Time.now
    else
      # current time + total duration of queue
      return Time.now + self.duration.minute
    end
  end

  def duration_hrs_min
    # "#{self.duration / 60} hrs #{self.duration % 60} min"
    hrsmin = "<span>#{self.duration / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{self.duration % 60}</span><span class='smaller relative raised'>min</span>"
    hrsmin.html_safe
  end

  def calculated_start_time

  end


end
