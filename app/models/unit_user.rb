class UnitUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  validates_uniqueness_of :user_id, scope: :unit_id

  after_save :update_total_time, only: [:index, :update, :create, :destroy]

private #######################

  def update_total_time
    @unit = self.unit
    @unit.duration = get_total_time
    @unit.save
  end

  def get_total_time
    hrs =  @unit.unit_users.pluck(:duration_hrs).sum
    mins = @unit.unit_users.pluck(:duration_min).sum
    puts "*"*30
    puts (hrs * 60) + mins
    puts "*"*30
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