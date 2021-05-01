class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :user_plant
  validates :tick_time, presence: true
  enum reminder_types: [:water_reminder, :trim_reminder, :fertilize_reminder]
  
  default_scope {order(created_at: :desc)}

  def self.reminder_enums
    return reminder_types.keys.zip(reminder_types.values)
  end

  def self.reminder_type_str(type_num)
    reverse_types = {}
    reminder_types.each do |str, num|
        reverse_types[num] = str
    end
    puts reverse_types.inspect
    result = reverse_types[type_num]
    return result[0, result.index('_reminder')]
  end
end
