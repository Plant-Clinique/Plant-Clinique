class ChatbotMessage < ApplicationRecord
    belongs_to :user
    validates :content, presence: true, length: { minimum: 1, maximum: 3500 }
end
