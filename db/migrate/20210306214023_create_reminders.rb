class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.integer :user_plant_id
      t.integer :user_id
      t.datetime :reminder_time
      t.string :description
      t.integer :type

      t.timestamps
    end
  end
end
