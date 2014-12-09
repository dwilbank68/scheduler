class User < ActiveRecord::Base
  has_many :unit_users
  belongs_to :unit
  has_many :units, :through => :unit_users
end

# class Unit < ActiveRecord::Base
#   belongs_to :owner
#   has_many :unit_users
#   has_many :users, :through => :unit_users
#
#   def total_duration
#     446 # placeholder till later
#   end
# end

# class UnitUser < ActiveRecord::Base
#   belongs_to :users
#   belongs_to :units
# end