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

    time_avail
  end

  def duration_hrs_min
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
      new_arr << obj
    end
    new_arr
  end

  def report_status
    unit = self
    if duration == 0
      self.reload
      @data = { :time_available => Time.now,
                :time_available_string => "--:--:--",
                :duration => 0,
                :uu_queue => [].to_json
      }
    else
      uu_queue = unit_users.map do |uu|
        user = uu.user
        { :unitId => unit.id,
          :id => uu.id,
          :name => user.name,
          :start_time_formatted => uu.start_time_formatted,
          :end_time => uu.end_time,
          :end_time_formatted => uu.end_time_formatted,
          :end_time_hidden => uu.end_time.to_s, #because in js, the UTC became a Z, and new Date(end_time) would fail
          :duration => uu.duration,
          :duration_string => uu.duration_hrs_min,
          :img => user.avatar.profile.url,
          :email =>  user.email,
          :emailFormatted =>  user.formatted_email1,
          :email2Formatted => user.formatted_email2,
          :phoneFormatted =>  user.formatted_phone1,
          :phone2Formatted => user.formatted_phone2,
          :note => uu.note }
      end
      @data = {
                :time_available => time_available,
                :time_available_string => "this will be replaced with a countdown",
                :duration => duration,
                :uu_queue => uu_queue
      }
    end
    @data
  end

  def end_time_formatted
    # defaults to the first user's timezone (currently PST)
    # fix this later with a view helper/decorator/whatever
    user = User.first
    if self.time_available
      self.time_available.in_time_zone(user.timezone).strftime('%b %e, %l:%M %p')
    else
      "Unit Available"
    end
  end

  def self.report_unit_statuses
    u_times = Unit.all.map do |u|
      { :id => u.id, :state => u.state, :duration => u.duration, :time_available => u.time_available || ""}
    end
    u_times.to_json
  end


end
