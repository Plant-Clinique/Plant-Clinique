class AddIntervalTickTimeToReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :interval, :integer
    add_column :reminders, :tick_time, :time
  end
end