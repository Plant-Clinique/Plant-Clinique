# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'net/http'
# require 'json'

User.delete_all
UserPlant.delete_all
Reminder.delete_all
Post.delete_all
Reply.delete_all
ChatbotMessage.delete_all
# PlantType.delete_all

puts "Finish deleting"

# 1.upto(8) do |page|
#   plants = JSON
#                 .parse(
#                   Net::HTTP.get(
#                     URI.parse(
#                       "https://trefle.io/api/v1/plants?page=#{page}&filter[edible_parts]=fruits&filter[vegetable]=true&token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw"
#                     )
#                   )
#                 )['data'].reject{ |plant| plant['common_name'] == nil }
#   plants.each do |plant|
#     PlantType.create(name: plant['common_name'], trefle_id: plant['id'])
#   end
# end

puts "Finish PlantType"

10.times do
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end

puts "Finish User"

20.times do
  UserPlant.create( user_id: User.all.sample.id,
                    name: Faker::Creature::Dog.name,
                    age: Faker::Number.within(range: 1..48),
                    plant_type: PlantType.all.sample.trefle_id,
                    img_url: Faker::Internet.url,
                    description: Faker::Movies::HarryPotter.quote)
end

puts "Finish UserPlant"

40.times do
  Reminder.create(user_plant_id: UserPlant.all.sample.id,
                  user_id: User.all.sample.id,
                  description: Faker::Movies::StarWars.quote,
                  reminder_type: Faker::Number.within(range: 0...Reminder.reminder_types.length),
                  interval: Faker::Number.within(range: 1..7),
                  tick_time: Faker::Time.between_dates(from: Date.today - 100, to: Date.today, period: :morning),
                  email_time: Faker::Time.between_dates(from: Date.today - 2, to: Date.today - 1, period: :all) # anytime between yesterday and today                
                )
end

puts "Finish Reminder"

10.times do
  Post.create(  user_id: User.all.sample.id,
                topic: Faker::Number.within(range: 0...Post.topics.length),
                title: Faker::Movies::Ghostbusters.quote,
                body: Faker::Movies::VForVendetta.speech)
end

puts "Finish Post"

20.times do
  Reply.create( user_id: User.all.sample.id,
                post_id: Post.all.sample.id,
                body: Faker::Movies::VForVendetta.speech)
end

puts "Finish Reply"

20.times do
  ChatbotMessage.create(  user_id: User.all.sample.id,
                          time_sent: Faker::Time.forward(days: 30, period: :morning),
                          from_bot: Faker::Boolean.boolean,
                          content: Faker::Lorem.sentence)
end

puts "Finish ChatbotMessage and everything!!"