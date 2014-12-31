# t.string :name
# t.string :screenName
# t.string :position
# t.string :imagePath
# t.string :state
# t.integer :duration, :default => 0 # minutes
# t.timestamp :time_available
#
# t.timestamps

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

  def time_available
    # @unit = self.unit
    if unit_users.length == 0
      return Time.now
    else
      # current time + total duration of queue
      return Time.now + self.duration.minute
    end
  end

  def total_duration

  end

  def calculated_start_time

  end


end
