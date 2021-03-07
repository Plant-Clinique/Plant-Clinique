class Reminder < ApplicationRecord
    belongs_to :user
    belongs_to :user_plant
    enum reminder_types: [:water_reminder, :trim_reminder, :fertilize_reminder]
end
