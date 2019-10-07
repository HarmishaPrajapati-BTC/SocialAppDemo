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
