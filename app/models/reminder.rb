class Reminder < ApplicationRecord
    belongs_to :user
    belongs_to :user_plant
end
