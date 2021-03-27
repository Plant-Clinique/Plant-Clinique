# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'net/http'
require 'json'

User.delete_all
UserPlant.delete_all
Reminder.delete_all
Post.delete_all
Reply.delete_all
ChatbotMessage.delete_all
PlantType.delete_all

10.times do
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end

20.times do
  UserPlant.create( user_id: User.all.sample.id,
                    name: Faker::Creature::Dog.name,
                    age: Faker::Number.within(range: 1..48),
                    plant_type: Faker::Food.vegetables,
                    img_url: Faker::Internet.url,
                    description: Faker::Movies::HarryPotter.quote)
end

40.times do
  Reminder.create(user_plant_id: UserPlant.all.sample.id,
                  user_id: User.all.sample.id,
                  reminder_time: Faker::Time.forward(days: 30, period: :morning),
                  description: Faker::Movies::StarWars.quote,
                  reminder_type: Faker::Number.within(range: 0...Reminder.reminder_types.length))
end

10.times do
  Post.create(  user_id: User.all.sample.id,
                topic: Faker::Number.within(range: 0...Post.topics.length),
                title: Faker::Movies::Ghostbusters.quote,
                body: Faker::Movies::VForVendetta.speech)
end

20.times do
  Reply.create( user_id: User.all.sample.id,
                post_id: Post.all.sample.id,
                body: Faker::Movies::VForVendetta.speech)
end

20.times do
  ChatbotMessage.create(  user_id: User.all.sample.id,
                          time_sent: Faker::Time.forward(days: 30, period: :morning),
                          from_bot: Faker::Boolean.boolean,
                          content: Faker::Lorem.sentence)
end

result = JSON.parse(Net::HTTP.get(URI.parse('https://trefle.io/api/v1/plants?filter_not%5Bedible_part%5D=null&token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw')))

plant_types = result['data'].map{ |plant| plant['common_name'] }.reject{ |plant| plant == nil }
plant_types.each do |plant_type|
  PlantType.create(name: plant_type)
end
