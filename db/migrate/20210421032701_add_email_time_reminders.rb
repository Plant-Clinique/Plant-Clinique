class AddEmailTimeReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :email_time, :datetime
  end
end
