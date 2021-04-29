class Post < ApplicationRecord
  # Using gem active_record-events, allowing to update edited post
  has_event :edit
  
  has_many :replies
  belongs_to :user
  enum topics: [:bugs, :disease, :color, :watering, :sunlight, :soil_care, :buying_plants, :temperature]

  validates :title, presence: true, length: { minimum: 1, maximum: 500 }
  validates :body, presence: true, length: { minimum: 1, maximum: 3500 }

  paginates_per 7
  
  def self.search(search)
    if search
      where(topic: search)
    else
      all
    end
  end
  
end
