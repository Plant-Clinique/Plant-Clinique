class RemindersUtils
  def self.reminders_by_category(user, reminder_type)
    if reminder_type.present?
      Reminder.where(user_id: user).where(reminder_type: Reminder.reminder_types[reminder_type.parameterize.underscore])
    else
      Reminder.where(user_id: user) 
    end
  end
end