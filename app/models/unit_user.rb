class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  # validates_uniqueness_of :user_id, scope: :unit_id

  after_commit :update_total_time
  after_destroy :update_total_time

  # default_scope {order('created_at ASC')}
  default_scope {order('end_time ASC')}

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

  def next_unit_user
    unit = self.unit
    queue = unit.unit_users
    idx = queue.index(self)
    queue[idx+1]
  end


  private


# TODO - move this into unit.rb because it belongs there, right? But they're triggered by UnitUser after_commit... ???

  # this happens after every unit_user create, update, or destroy
  def update_total_time
    @unit = self.unit
    @unit.update(:duration => get_total_time, :time_available => @unit.calculated_time_available )
  end

  def get_total_time
    total_queue_duration = @unit.unit_users.pluck(:duration).sum
    logger.info('----------------unit#get_total_time is triggered, returning ' + total_queue_duration.to_s)
    total_queue_duration
  end



end



# curl -X POST https://api.twilio.com/2010-04-01/Accounts/ACd7c0591256b00094cf9f60c41b7a5d51/SMS/Messages.json \
#     -u ACd7c0591256b00094cf9f60c41b7a5d51:edc5cd8e9f6164cf6dbd0fa0735a1014 \
#     --data-urlencode "From=+14246723527" \
#     --data-urlencode "To=+18186489466" \
#     --data-urlencode 'Body=VTR 44 will be available in 5 minutes. Press 1 to confirm, or press 0 to remove yourself from the queue.'