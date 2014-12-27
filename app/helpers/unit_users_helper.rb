module UnitUsersHelper

  def seconds_to_hms(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end
end