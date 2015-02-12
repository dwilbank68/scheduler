desc "Updates all units and unit-users."
task :update => :environment do

  expired_unit_users = UnitUser.where("end_time <= ?", Time.current)
  expired_unit_users.each do |expired|
    expired_user = expired.user
    next_user = expired.next_unit_user.user if expired.next_unit_user
    time_expired_message = "Sent at #{Time.now}. Your time on #{expired.unit.screen_name} has expired."
    expired.destroy
    expired_user.send_sms(time_expired_message)
    UserMailer.send_email(expired_user, expired_user.email, time_expired_message).deliver if expired_user.contact_flags[1] == "1"
    UserMailer.send_email(expired_user, expired_user.email2, time_expired_message+" #").deliver if expired_user.contact_flags[3] == "1"
    if next_user
      time_begins_message = "Sent at #{Time.now}. Your time on #{expired.unit.screen_name} has begun."
      next_user.send_sms(time_begins_message)
      UserMailer.send_email(next_user, next_user.email, time_begins_message).deliver if next_user.contact_flags[1] == "1"
      UserMailer.send_email(next_user, next_user.email, time_begins_message+" #").deliver if next_user.contact_flags[3] == "1"
    end
  end

  expiring_soon_users = UnitUser.where("end_time between ? and ?", Time.current + 4.minutes, Time.current + 5.minutes)
  if expiring_soon_users
    expiring_soon_users.each do |expiring|
      expiring_user = expiring.user
      next_user = expiring.next_unit_user.user if expiring.next_unit_user
      unit_name = expiring.unit.screen_name
      expiring_soon_message = "Sent at #{Time.now}. Your time on #{unit_name} will expire in 5 minutes."
      expiring_user.send_sms(expiring_soon_message)
      UserMailer.send_email(expiring_user, expiring_user.email,  expiring_soon_message).deliver if expiring_user.contact_flags[1] == "1"
      UserMailer.send_email(expiring_user, expiring_user.email2, expiring_soon_message+" #").deliver if expiring_user.contact_flags[3] == "3"
      if next_user
        begin_soon_message = "Sent at #{Time.now}. Your time on #{unit_name} will begin in 5 minutes"
        next_user.send_sms(begin_soon_message)
        UserMailer.send_email(next_user, next_user.email,  begin_soon_message).deliver if next_user.contact_flags[1] == "1"
        UserMailer.send_email(next_user, next_user.email2, begin_soon_message+" #").deliver if next_user.contact_flags[3] == "1"
      end
    end
  end

  puts "Time.current is #{Time.current}"
  puts "UnitUser.first.end_time is #{UnitUser.first.end_time}" if UnitUser.first
  puts "destroyed #{expired_unit_users.inspect}"
end