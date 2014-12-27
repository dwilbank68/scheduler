# t.string :name, :null => false
# t.string :phone
# t.string :phone2
# t.string :email
# t.string :email2
# t.string :sms
# t.string :role

class User < ActiveRecord::Base
  has_many :unit_users
  belongs_to :unit
  has_many :units, :through => :unit_users

  validates :name, :email, :presence => true

  validates :name,
            :length => { :minimum => 2, :maximum => 30 },
            # :length => { in: 2..30 },
            :format => { :with => /\A[\w\s]+\z/ }

  validates :email,
            :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

  validates :name, :phone, :email,
            :uniqueness => true

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