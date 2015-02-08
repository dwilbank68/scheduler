class Unit < ActiveRecord::Base

  belongs_to :owner
  has_many :unit_users, dependent: :destroy
  has_many :users, :through => :unit_users

  mount_uploader :unit_pic, UnitPicUploader


  def pos_x
    self.position.split('x').first.to_i
  end

  def pos_y
    self.position.split('x').last.to_i
  end

  def calculated_time_available
    if self.unit_users.count == 0
      time_avail = nil
    else
      self.reload
      time_avail = self.unit_users.last.end_time
    end
    # puts "*"*30
    # puts "unit_users.count for unit #{self.id} is #{unit_users.count}"
    puts "----------------self.unit_users.count is returning " + self.unit_users.count.to_s
    puts "----------------calculated_time_available is returning " + time_avail.to_s
    # puts "*"*30
    time_avail
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

  def report_status
    unit = Unit.find 20
    if duration == 0
      logger.info('-------------in unit#report_status, duration equals zero')
      logger.info('-------------in unit#report_status, self.duration equals ' + self.duration.to_s)
      logger.info('-------------in unit#report_status, self equals ' + self.inspect)
      self.reload
      logger.info('-------------in unit20#report_status, unit.duration equals ' + unit.duration.to_s)
      @data = { :time_available => Time.now,
                :time_available_string => "--:--:--",
                :duration => 0,
                :uu_queue => [].to_json
      }
    else
      logger.info('-------------in unit#report_status, duration NOT equals zero')
      min = duration
      uu_times = unit_users.map do |uu|
        { :id => uu.id,
          :start_time_formatted => uu.start_time_formatted,
          :end_time_formatted => uu.end_time_formatted,
          :duration => uu.duration,
          :note => uu.note }
      end
      @data = { :time_available => time_available,
                :time_available_string => "hey",
                :duration => min,
                :uu_queue => uu_times.to_json
      }
    end
    @data.to_json
  end


end
