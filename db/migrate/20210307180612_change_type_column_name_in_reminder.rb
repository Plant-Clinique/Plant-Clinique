class ChangeTypeColumnNameInReminder < ActiveRecord::Migration[6.1]
  def change
    rename_column :reminders, :type, :reminder_type
  end
end
