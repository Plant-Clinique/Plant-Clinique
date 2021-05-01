class Post < ApplicationRecord
  # Using gem active_record-events, allowing to update edited post

  
  has_event :edit
  
  has_many :replies
  belongs_to :user
  enum topics: [:bugs, :disease, :color, :watering, :sunlight, :soil_care, :buying_plants, :temperature]

  scope :ordered_by_newest, -> {order(created_at: :desc)}
  scope :ordered_by_oldest, -> {order(created_at: :asc)}
  scope :ordered_by_most_replies, -> {left_joins(:replies).group(:id).order('COUNT(replies.id) DESC')}
  scope :ordered_by_least_replies, -> {left_joins(:replies).group(:id).order('COUNT(replies.id) ASC')}
  
  validates :title, presence: true, length: { minimum: 1, maximum: 500 }
  validates :body, presence: true, length: { minimum: 1, maximum: 3500 }
  validates :topic, presence: true

  paginates_per 7
  
  def self.search(search)
    if search
      where(topic: search)
    else
      all
    end
  end
  
end
