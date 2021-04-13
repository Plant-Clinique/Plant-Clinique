class UserPlant < ApplicationRecord
    belongs_to :user
    has_many :reminders

    validates :name, presence: true, length: { maximum: 100 }
    validates :age, numericality: true
    validates :plant_type, presence: true
end
