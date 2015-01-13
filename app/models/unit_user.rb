class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  # validates_uniqueness_of :user_id, scope: :unit_id

  after_commit :update_total_time
  after_destroy :update_total_time

  default_scope {order('created_at ASC')}

  def hrs_min
    "#{self.duration / 60} hrs #{self.duration % 60} min"
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


# class Unit < ActiveRecord::Base
#
#   belongs_to :owner
#   has_many :unit_users
#   has_many :users, :through => :unit_users
#
#   def total_duration
#     446 # placeholder till later
#   end

# end

# class User < ActiveRecord::Base
#   has_many :unit_users
#   belongs_to :unit
#   has_many :units, :through => :unit_users
# end