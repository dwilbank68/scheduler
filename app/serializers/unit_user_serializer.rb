class UnitUserSerializer < ActiveModel::Serializer
  attributes :id, :unit_id, :user_id, :start_time, :duration, :end_time, :note, :start_time_formatted, :end_time_formatted, :duration_hrs_min
end
