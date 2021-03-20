class Post < ApplicationRecord
    has_many :replies
    belongs_to :user
    enum topics: [:bugs, :disease, :color, :watering, :sunlight, :soil_care, :buying_plants, :temperature]

    def self.search(search)
      if search
        where(topic: search)
      else
        all
      end
    end
end
