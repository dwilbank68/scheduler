# t.string   "name"
# t.string   "screenName"
# t.string   "position"
# t.string   "total_duration"
# t.string   "imagePath"
# t.string   "state"

class Unit < ActiveRecord::Base

  belongs_to :owner
  has_many :unit_users
  has_many :users, :through => :unit_users



  def pos_x
    self.position.split('x').first.to_i
  end

  def pos_y
    self.position.split('x').last.to_i
  end

  def total_duration
    446 # placeholder till later
  end


end
