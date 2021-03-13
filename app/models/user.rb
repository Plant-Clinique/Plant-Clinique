class User < ApplicationRecord
    has_many :user_plants
    has_many :reminders
    has_many :chatbot_messages
    has_many :replies
    has_many :posts
end
