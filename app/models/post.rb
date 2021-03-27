class Post < ApplicationRecord
    has_many :replies
    belongs_to :user
    enum topics: [:bugs, :disease, :color, :watering, :sunlight, :soil_care, :buying_plants, :temperature]

    validates :title, presence: true, length: { minimum: 1, maximum: 100 }
    validates :body, presence: true, length: { minimum: 1, maximum: 500 }

    def self.search(search)
      if search
        where(topic: search)
      else
        all
      end
    end
end
