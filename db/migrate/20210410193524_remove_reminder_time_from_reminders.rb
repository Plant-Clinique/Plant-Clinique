class RemoveReminderTimeFromReminders < ActiveRecord::Migration[6.1]
  def change
    remove_column :reminders, :reminder_time, :datetime
  end
end
