# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#### Create user
User.create email: "warden_demo@gmail.com", password: "Aa@123456"
Admin.create user_id: User.first.id
Corporation.create user_id: User.first.id
