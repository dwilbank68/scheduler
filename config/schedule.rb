set :output, "#{path}/scheduler.log"

every 1.minute do
  rake "update", environment: 'development'
end
