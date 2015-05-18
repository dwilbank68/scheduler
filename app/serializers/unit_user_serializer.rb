class UnitUserSerializer < ActiveModel::Serializer
  attributes :id,
             :unit_id,
             :user_id,
             :name,
             :start_time,
             :duration,
             :end_time,
             :note,
             :start_time_formatted,
             :end_time_formatted,
             :duration_hrs_min,
             :img,
             :emailFormatted,
             :email2Formatted,
             :phoneFormatted,
             :phone2Formatted

end
