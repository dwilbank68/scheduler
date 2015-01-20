desc "Updates all units and unit-users."
task :update => :environment do
  expired_unit_users = UnitUser.where("end_time <= ?", Time.current)
  expired_unit_users.each do |uu|
    expired_user = uu.user
    uu.destroy
  end
  puts "destroyed #{expired_unit_users.inspect}"
end