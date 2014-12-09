class Unit < ActiveRecord::Base

  belongs_to :owner
  has_many :unit_users
  has_many :users, :through => :unit_users


  def total_duration
    446 # placeholder till later
  end


end
