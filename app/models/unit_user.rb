class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  # validates_uniqueness_of :user_id, scope: :unit_id

  after_commit :update_total_time
  after_destroy :update_total_time

  default_scope {order('created_at ASC')}

  def duration_hrs_min
    # "#{self.duration / 60} hrs #{self.duration % 60} min"
    hrsmin = "<span>#{self.duration / 60}</span><span class='smaller relative raised'>hrs</span> <span>#{self.duration % 60}</span><span class='smaller relative raised'>min</span>"
    hrsmin.html_safe
  end

  def start_time_formatted # as a local time string
    self.start_time.in_time_zone(self.user.timezone).strftime('%b %e, %l:%M %p')
  end

  def end_time_formatted # as a local time string
    self.end_time.in_time_zone(self.user.timezone).strftime('%b %e, %l:%M %p')
  end

  private


# TODO - move this into unit.rb because it belongs there, right? But they're triggered by UnitUser after_commit... ???

  def update_total_time
    @unit = self.unit
    @unit.duration = get_total_time
    @unit.save
    # puts "*"*30
    # puts "@unit.duration is #{@unit.duration}"
    # puts "*"*30
  end

  def get_total_time
    total_queue_duration = @unit.unit_users.pluck(:duration).sum
    # puts "*"*30
    # puts "total_queue_duration is #{total_queue_duration} - #{@unit.unit_users.count} in queue"
    # puts "*"*30
    total_queue_duration
  end

end
