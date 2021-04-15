class Reminder < ApplicationRecord
    belongs_to :user
    belongs_to :user_plant
    validates :reminder_time, presence: true
    enum reminder_types: [:water_reminder, :trim_reminder, :fertilize_reminder]
end
