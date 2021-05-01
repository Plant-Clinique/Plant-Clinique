class RemindersUtils
  def self.reminders_by_category(user, reminder_type)
    if reminder_type.present?
      Reminder.where(user_id: user).where(reminder_type: Reminder.reminder_types[reminder_type.parameterize.underscore])
    else
      Reminder.where(user_id: user) 
    end
  end

  def self.reminder_type_dropdown
    return Reminder.reminder_enums
  end

  def self.user_plant_dropdown(user)
    this_user_plants = UserPlant.where(user_id: user)
    return this_user_plants.pluck(:name).zip(this_user_plants.pluck(:id))
  end
end