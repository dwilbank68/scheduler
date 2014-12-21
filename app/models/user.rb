# t.string   "name"
# t.string   "phone"
# t.string   "SMS"
# t.string   "email"

class User < ActiveRecord::Base
  has_many :unit_users
  belongs_to :unit
  has_many :units, :through => :unit_users

  validates :name,
            :presence => true,
            # :length => { :minimum => 2, :maximum => 30 },
            :length => { in: 2..30 },
            :format => { :with => /^\w+$/ },
            :uniqueness => { :case_sensitive => false }

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

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