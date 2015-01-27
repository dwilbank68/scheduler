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

  def next_unit_user
    unit = self.unit
    queue = unit.unit_users
    idx = queue.index(self)
    queue[idx+1]
  end

  private


# TODO - move this into unit.rb because it belongs there, right? But they're triggered by UnitUser after_commit... ???

  def update_total_time
    @unit = self.unit
    @unit.duration = get_total_time
    @unit.time_available = @unit.unit_users.last.end_time
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



# curl -X POST https://api.twilio.com/2010-04-01/Accounts/ACd7c0591256b00094cf9f60c41b7a5d51/SMS/Messages.json \
#     -u ACd7c0591256b00094cf9f60c41b7a5d51:edc5cd8e9f6164cf6dbd0fa0735a1014 \
#     --data-urlencode "From=+14246723527" \
#     --data-urlencode "To=+18186489466" \
#     --data-urlencode 'Body=VTR 44 will be available in 5 minutes. Press 1 to confirm, or press 0 to remove yourself from the queue.'