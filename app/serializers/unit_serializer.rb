class UnitSerializer < ActiveModel::Serializer
  attributes :id, :screen_name, :position, :state, :duration, :time_available, :end_time_formatted, :unit_pic, :user_disabler, :when_disabled, :notes

  has_many :unit_users
end
