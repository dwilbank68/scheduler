require 'faker'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

####### UNITS #######

# t.string :name
# t.string :screenName
# t.string :position
# t.string :imagePath
# t.string :state
# t.integer :duration, :default => 0 # minutes
# t.timestamp :time_available
#
# t.timestamps

machine_names = ['vtr32', 'vtr33', 'vtr35', 'vtr37', 'vtr38']
machine_screen_names = ['VTR 32', 'VTR 33', 'VTR 35', 'VTR 37', 'VTR 38']
machine_positions = ['24x5', '235x25', '455x26', '711x22', '658x291']

Unit.destroy_all
machine_names.each_with_index do |name, idx|
  unit = Unit.new
  unit.name = name
  unit.screenName = machine_screen_names[idx]
  unit.position = machine_positions[idx]
  unit.imagePath = 'data:image/jpeg;base64,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'
  unit.state = 'active'
  unit.save
end



####### USERS #######

# t.string   "name"
# t.string   "phone"
# t.string   "phone2"
# t.string   "email"
# t.string   "email2"
# t.string   "sms"
# t.string   "role"
# t.string   "image"
User.destroy_all
10.times do
  user = User.new(
      name:  Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.cell_phone
  )
  user.save
end



####### UNIT_USERS #######

# t.integer  "unit_id"
# t.integer  "user_id"
# t.datetime "start_time"
# t.integer  "duration",   default: 5
# t.text     "note"

# UnitUser.destroy_all
# 8.times do
#  unit_user = UnitUser.new(
#     unit_id:    Unit.all.sample.id,
#     user_id:    User.all.sample.id,
#     start_time: Time.now,
#     duration:   rand(0..480),
#     note:       Faker::Lorem.sentence(rand(0..8))
#  )
#   unit_user.save
#
# end