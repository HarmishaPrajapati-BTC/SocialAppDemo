# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(first_name: 'Harmisha') do |user|
  user.last_name = 'Prajapati'
  user.email = 'harmisha.prajapati@botreetechnologies.com'
  user.contact_number = '8754213265'
  user.address = 'Ahmedabad'
  user.password = '123456'
  user.add_role :admin
  user.save!
  puts 'New User Admin created'
end

User.find_or_create_by(first_name: 'John') do |user|
  user.last_name = 'doe'
  user.email = 'john@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'Singapore'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User john created'
end

User.find_or_create_by(first_name: 'Sofiya') do |user|
  user.last_name = 'torito'
  user.email = 'sofiya@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'USA'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User sofiya created'
end

User.find_or_create_by(first_name: 'Dom') do |user|
  user.last_name = 'amoyal'
  user.email = 'dom@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'Singapore'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User dom created'
end

User.find_or_create_by(first_name: 'Tom') do |user|
  user.last_name = 'cat'
  user.email = 'tom@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'Canada'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User tom created'
end

User.find_or_create_by(first_name: 'Jerry') do |user|
  user.last_name = 'cute'
  user.email = 'jerry@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'Canada'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User jerry created'
end

User.find_or_create_by(first_name: 'Doremon') do |user|
  user.last_name = 'gadget'
  user.email = 'doremon@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'Japan'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User doremon created'
end

User.find_or_create_by(first_name: 'Minion') do |user|
  user.last_name = 'wierd'
  user.email = 'minion@gmail.com'
  user.contact_number = '8754213265'
  user.address = 'London'
  user.password = '123456'
  user.add_role :member
  user.save!
  puts 'New User minion created'
end
