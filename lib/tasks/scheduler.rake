lib/tasks/scheduler.rake

desc "Updates all units and unit-users."
task :update => :environment do
  expired_users = User.where("account_expiration < ?", DateTime.now)
  expired_users.map do |user|
    user.subscribed = false
    user.account_activation = nil
    user.account_expiration = nil
    user.save
    user.wikis.each {|wiki| wiki.update(private:false)}
  end
end