class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  after_commit :update_total_time
  after_destroy :update_total_time

  default_scope {order('created_at ASC')}

  def duration_hrs_min
    # hrsmin = "<span>#{self.duration / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{self.duration % 60}</span><span class='smaller relative raised'>min</span>"
    # hrsmin.html_safe
    (self.duration / 60).to_s + ' hrs ' + (self.duration % 60).to_s + ' min'
  end

  def start_time_formatted # as a local time string
    self.start_time.in_time_zone(self.user.timezone).strftime('%b %e, %l:%M %p')
  end

  def end_time_formatted # as a local time string
    self.end_time.in_time_zone(self.user.timezone).strftime('%b %e, %l:%M %p')
  end

  def next_unit_user
    unit = self.unit
    queue = unit.unit_users
    idx = queue.index(self)
    queue[idx+1]
  end


  private

  def update_total_time
    @unit = self.unit
    @unit.update(:duration => get_total_time, :time_available => @unit.calculated_time_available )
  end

  def get_total_time
    #logger.info('----------------unit_user#get_total_time is triggered, returning ' + total_queue_duration.to_s)
    @unit.unit_users.pluck(:duration).sum
  end

end
