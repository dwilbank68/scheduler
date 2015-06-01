class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  validates :unit_id, :user_id, :presence => true, :numericality => {:only_integer => true}

  after_commit :update_total_time
  after_destroy :update_total_time

  default_scope {order('created_at ASC')}

  def duration_hrs_min
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

  def name
    self.user.name
  end

  def img
    self.user.avatar.profile.url
  end

  def emailFormatted
    self.user.formatted_email1
  end

  def email2Formatted
    self.user.formatted_email2
  end

  def phoneFormatted
    self.user.formatted_phone1
  end

  def phone2Formatted
    self.user.formatted_phone2
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
