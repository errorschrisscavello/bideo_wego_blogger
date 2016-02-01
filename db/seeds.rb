# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == 'development'
  puts 'Destroying old data'
  Rake::Task['db:migrate:reset'].invoke
  puts 'Data destroyed!'
end

puts 'Creating users'
User.create(
  :username => 'foobar1234',
  :email => 'foo1234@bar.com',
  :password => 'password'
)

puts 'done!'

