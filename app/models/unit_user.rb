class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  # validates_uniqueness_of :user_id, scope: :unit_id

  after_commit :update_total_time
  # after_destroy :update_total_time

  default_scope {order('start_time DESC')}

  # def calculated_start_time
  #   @unit = self.unit
  #   if @unit.unit_users.length = 0
  #     return Time.now
  #   else
  #     return Time.now + 3.hour
  #   end
  # end

private #######################


# TODO - move this into unit.rb because it belongs there, right? But they're triggered by UnitUser after_commit... ???

  def update_total_time
    @unit = self.unit
    @unit.duration = get_total_time
    @unit.save
  end

  def get_total_time
    hrs =  @unit.unit_users.pluck(:duration_hrs).sum
    mins = @unit.unit_users.pluck(:duration_min).sum
    # puts "*"*30
    # puts (hrs * 60) + mins
    # puts "*"*30
    (hrs * 60) + mins
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