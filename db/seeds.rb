# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |num|
  u = User.new
  u.password = num.to_s
  u.username = num.to_s
  u.save!

  c = Cat.new
  c.name = num.to_s
  c.birth_date = Date.today
  c.color = "black"
  c.sex = "M"
  c.user_id = num + 1
  c.save!

end
